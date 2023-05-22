//
//  ContentView.swift
//  UALtest
//
//  Created by Maxim Potapov on 20.05.2023.
//

import SwiftUI
import ComposableArchitecture

struct AnimalCategoriesDomain {
  struct AnimalCategoriesState: Equatable {
    var categories: [Animal] = []
  }
  
  enum AnimalCategoriesAction: Equatable {
    case fetchAnimals
    case fetchAnimalsResponse(TaskResult<[Animal]>)
  }
  
  struct AnimalCategoriesEnvironnment {
    var fetchAnimals:  @Sendable () async throws -> [Animal]
  }
  
  static let animalCategoriesReducer = AnyReducer<AnimalCategoriesState, AnimalCategoriesAction, AnimalCategoriesEnvironnment> { state, action, environment in
    switch action {
      case .fetchAnimals:
        return .task {
          await .fetchAnimalsResponse(
            TaskResult { try await environment.fetchAnimals() }
          )
        }
      case .fetchAnimalsResponse(.success(let products)):
        state.categories = products
        return .none
      case .fetchAnimalsResponse(.failure(let error)):
        print(error.localizedDescription)
        return .none
    }
  }
}


struct ContentView: View {
  enum ItemAction: Identifiable {
    case navigateToDetail
    case showAd
    case notClickable
    
    var id: Int {
      return 0
    }
  }
  
  @State private var selectedItemAction: ItemAction?
  @State private var showAdAlert = false
  @State private var showAdView = false
  let store: Store<AnimalCategoriesDomain.AnimalCategoriesState, AnimalCategoriesDomain.AnimalCategoriesAction>
  
  var body: some View {
    ZStack {
      NavigationStack {
        WithViewStore(self.store) { viewStore in
          List(viewStore.categories) { item in
            switch determineItemAction(item) {
              case .navigateToDetail:
                NavigationLink(destination: CategoryDetailView(facts: item.content ?? [])) {
                  ListCategoryItem(item: item)
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(PlainButtonStyle())
              case .showAd:
                Button(action: {
                  selectedItemAction = .showAd
                  self.showAdAlert.toggle()
                }) {
                  ListCategoryItem(item: item)
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(PlainButtonStyle())
              case .notClickable:
                ListCategoryItem(item: item)
                  .listRowSeparator(.hidden)
            }
          }
          .listStyle(.inset)
          .listRowSeparator(.hidden)
          .task {
            viewStore.send(.fetchAnimals)
          }
          .alert(isPresented: $showAdAlert) {
            return Alert(
              title: Text("Watch Ad"),
              message: Text("Do you want to watch an ad to access this item?"),
              primaryButton: .default(Text("OK") , action: {
                withAnimation {
                  self.showAdView.toggle()
                  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showAdView = false
                  }
                }
              }),
              secondaryButton: .cancel(Text("Cancel")))
          }
        }
      }
      
      if showAdView {
        HStack {
          Spacer()
          
          VStack {
            
            Spacer()
            
            Text("You are watching ad :)")
              .font(.title)
            
            Spacer()
          }
          
          Spacer()
        }
        .frame(
          maxWidth: .infinity,
          maxHeight: .infinity
        )
      }
    }
  }
  
  private func determineItemAction(_ item: Animal) -> ItemAction {
    if !((item.content?.isEmpty) != nil) {
      return .notClickable
    } else if item.status == "paid" {
      return .showAd
    } else {
      return .navigateToDetail
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: Store(
      initialState: AnimalCategoriesDomain.AnimalCategoriesState(),
      reducer: AnimalCategoriesDomain.animalCategoriesReducer,
      environment: AnimalCategoriesDomain.AnimalCategoriesEnvironnment(fetchAnimals: APIClient.live.fetchCategories)
    ))
  }
}



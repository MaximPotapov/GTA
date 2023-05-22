//
//  UALtestApp.swift
//  UALtest
//
//  Created by Maxim Potapov on 18.05.2023.
//
import ComposableArchitecture
import SwiftUI

@main
struct UALtestApp: App {
  let store = Store<AnimalCategoriesDomain.AnimalCategoriesState, AnimalCategoriesDomain.AnimalCategoriesAction>(
    initialState: AnimalCategoriesDomain.AnimalCategoriesState(),
    reducer: AnimalCategoriesDomain.animalCategoriesReducer,
    environment: AnimalCategoriesDomain.AnimalCategoriesEnvironnment(
      fetchAnimals: APIClient.live.fetchCategories
    )
  )
  
  var body: some Scene {
    WindowGroup {
       ContentView(store: store)
     }
  }
}

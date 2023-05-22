//
//  CategotyDetailView.swift
//  UALtest
//
//  Created by Maxim Potapov on 20.05.2023.
//

import SwiftUI
import Kingfisher

struct CategoryDetailView: View {
  var facts: [Fact]
  @State private var factIndex = 0
  
  var body: some View {
    ZStack {
      Color.purple.opacity(0.3)
        .ignoresSafeArea()
      
      VStack {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(alignment: .center) {
          
            ForEach(facts, id: \.id) { fact in
              FactItemView(fact: fact)
                .frame(width: UIScreen.main.bounds.width)
            }
            
            
        
          }
          .offset(x: -CGFloat(factIndex) * UIScreen.main.bounds.width, y: 0)
        }
        .scrollDisabled(true)
        
        Spacer()
        
        Buttons
      }
      .background(Color.white)
      .cornerRadius(20)
      .padding(.vertical, 50)
      .padding(.horizontal, 20)
    }
  }
  
  private var Buttons: some View {
    HStack(alignment: .center) {
      Button("Show Previous") {
        withAnimation {
          factIndex = max(factIndex - 1, 0)
        }
      }
      .disabled(factIndex == 0)
      
      Spacer()
      
      Button("Show Next") {
        withAnimation {
          factIndex = min(factIndex + 1, facts.count - 1)
        }
      }
      .disabled(factIndex == facts.count - 1)
    }
    .padding()
  }
}



//struct CategotyDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    CategoryDetailView(facts: [
//      Fact(
//        id: UUID(),
//        fact: "During the Renaissance, detailed portraits of the dog as a symbol of fidelity and loyalty appeared in mythological, allegorical, and religious art throughout Europe, including works by Leonardo da Vinci, Diego Velázquez, Jan van Eyck, and Albrecht Durer.",
//        image: "https://images.dog.ceo/breeds/basenji/n02110806_4150.jpg"
//      ),
//      Fact(
//        id: UUID(),
//        fact: "If never spayed or neutered, a female dog, her mate, and their puppies could produce over 66,000 dogs in 6 years!",
//        image: "https://images.dog.ceo/breeds/puggle/IMG_075427.jpg"
//      )
//    ]
//    )
//  }
//}

struct FactItemView: View {
  let fact: Fact
  
  var body: some View {
    VStack {
      KFImage(URL(string: fact.image))
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 150, height: 150)
      
      Text(fact.fact)
        .frame(width: 300)
    }
  }
}

struct ScrollViewWidthPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}



//
//  ListCategoryItem.swift
//  UALtest
//
//  Created by Maxim Potapov on 20.05.2023.
//

import SwiftUI
import Kingfisher

struct ListCategoryItem: View {
    var item: Animal
    @State var isAvailable: Bool = false
    
    var body: some View {
        ZStack {
          Color.purple
              .ignoresSafeArea()
              .cornerRadius(6)
              .opacity(0.3)
          
            HStack {
                KFImage(URL(string: item.image))
                    .resizable()
                    .cornerRadius(6)
                    .frame(width: 120, height: 90)
                    .padding(.horizontal, 5)
                
                VStack(alignment: .leading) {
                    Text(item.title)
                    .foregroundColor(.black)
                    
                    Text(item.description)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(0)
                    
                    Spacer()
                    
                    if item.status == "paid" {
                        Text("Premium")
                        .opacity(isAvailable ? 1 : 0)
                    }
                }
                .padding(.vertical, 10)
            }
            .frame(height: 100)
            .cornerRadius(6)
            .background(.clear)
            .onAppear {
                if ((item.content?.isEmpty) != nil) {
                    isAvailable = true
                }
            }
            
            if !isAvailable {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .cornerRadius(6)
                
                Text("COMING SOON")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

//struct ListCategoryItem_Previews: PreviewProvider {
//  static var previews: some View {
//    ListCategoryItem(item: TestAnimal(title: "Dragons 🐉",
//                                      description: "Dragons not real, but beautiful :)",
//                                      image: "https://static.wikia.nocookie.net/monster/images/6/6e/DragonRed.jpg/",
//                                      status: "paid",
//                                      order: 4,
//                                      content: []),
//                     isAvailable: false)
//  }
//}

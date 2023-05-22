//
//  Vendor.swift
//  UALtest
//
//  Created by Maxim Potapov on 18.05.2023.
//

import Foundation
import ComposableArchitecture

struct Animal: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var image: String
    var status: String
    var order: Int
    var content: [Fact]?

    private enum CodingKeys: String, CodingKey {
        case title, description, image, status, order, content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.status = try container.decode(String.self, forKey: .status)
        self.order = try container.decode(Int.self, forKey: .order)
        self.content = try container.decodeIfPresent([Fact].self, forKey: .content)
    }
}

struct Fact: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var fact: String
    var image: String
  
  private enum CodingKeys: String, CodingKey {
    case fact, image
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.fact = try container.decode(String.self, forKey: .fact)
    self.image = try container.decode(String.self, forKey: .image)
  }
}


struct TestAnimal: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var image: String
    var status: String
    var order: Int
    var content: [Fact]?
}

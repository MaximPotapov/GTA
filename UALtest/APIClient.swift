//
//  APIClient.swift
//  UALtest
//
//  Created by Maxim Potapov on 20.05.2023.
//

import Foundation

struct APIClient {
  var fetchCategories: () async throws -> [Animal]
  
  struct Failure: Error {}
}

extension APIClient {
  static let live = Self(
    fetchCategories: {
      let (data, _) = try await URLSession.shared
        .data(from: URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")!)
      do {
        let animals = try JSONDecoder().decode([Animal].self, from: data)
        return animals
      } catch {
        print("Error decoding JSON: \(error)")
      }
      return []
    }
  )
}

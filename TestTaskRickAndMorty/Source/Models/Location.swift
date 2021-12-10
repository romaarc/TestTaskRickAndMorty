//
//  Location.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import Foundation

struct Location: Decodable, Hashable  {
    var uuid = UUID()
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, created
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
//MARK: - LocationURLParameters
struct LocationURLParameters: Decodable {
    var page: String?
    var name: String?
}

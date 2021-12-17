//
//  Location.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import Foundation

struct Location: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let created: Date
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, residents, created, url
    }
}
//MARK: - LocationURLParameters
struct LocationURLParameters: Decodable {
    var page: String?
    var name: String?
}

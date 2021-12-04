//
//  Character.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: String
    let created: Date
    
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, created
        case imageURL = "image"
    }
}

struct CharacterURLParametrs {
    let page: String?
    let name: String?
    let status: String?
    let gender: String?
}

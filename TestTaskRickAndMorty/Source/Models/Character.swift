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

struct CharacterURLParameters {
    var page: String?
    var name: String?
    var status: String?
    var gender: String?
}

extension CharacterURLParameters {
    
    init(page: String, name: String) {
        self.page = page
        self.name = name
        self.status = nil
        self.gender = nil
    }
   
    init(page: String) {
        self.page = page
        self.name = nil
        self.status = nil
        self.gender = nil
    }
}

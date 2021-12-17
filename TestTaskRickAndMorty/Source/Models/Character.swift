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
    let type: String
    let gender: String
    let origin: Origin
    let location: CharacterLocation
    let episode: [String]
    let imageURL: String
    let created: Date
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, episode, created, url
        case imageURL = "image"
    }
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}
    //MARK: - CharacterURLParameters
struct CharacterURLParameters: Decodable {
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
    
    init(page: String, status: String, gender: String) {
        self.page = page
        self.name = nil
        self.status = status
        self.gender = gender
    }
}

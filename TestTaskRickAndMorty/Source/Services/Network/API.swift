//
//  API.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

enum API {
    static let main = "https://rickandmortyapi.com"
    
    enum TypeOf {
        static let characters = "/api/character/"
        static let locations = "/api/location/"
        static let episodes = "/api/episode/"
    }
}

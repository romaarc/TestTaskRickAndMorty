//
//  APIConstants.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

enum APIConstants {
    static let rickMortyURL = "https://rickandmortyapi.com"
}

enum APIType {
    static let getCharacters = "/api/character/"
    static let getLocations = "/api/location/"
    static let getEpisodes = "/api/episode/"
}

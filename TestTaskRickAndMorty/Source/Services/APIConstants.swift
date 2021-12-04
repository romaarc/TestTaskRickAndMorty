//
//  APIConstants.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

enum APIConstants {
    static let rickMortyURL = "https://rickandmortyapi.com/api"
}

enum APIType {
    static let popular = "popular"
}

enum LoadingDataType {
    case nextPage
    case reload
}

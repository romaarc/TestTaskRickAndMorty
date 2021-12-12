//
//  CharacterViewModel.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 05.12.2021.
//

import Foundation

struct CharacterViewModel {
    let id: Int
    let name: String
    let gender: String
    let status: String
    let imageURL: String
    let species: String
    let type: String
    let origin: Origin
    let location: CharacterLocation
    let episodes: [String]
}

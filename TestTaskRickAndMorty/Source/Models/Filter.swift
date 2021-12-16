//
//  Filter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 15.12.2021.
//

import Foundation

struct Filter {
    let statusCharacters = ["Alive", "Dead", "Unknown"]
    let genderCharacters = ["Female", "Male", "Genderless", "Unknown"]
    var statusIndexPath: IndexPath?
    var genderIndexPath: IndexPath?
}

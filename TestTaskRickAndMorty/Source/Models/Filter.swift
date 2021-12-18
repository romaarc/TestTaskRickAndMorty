//
//  Filter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 15.12.2021.
//

import Foundation

struct Filter {
    let statusCharacters = ["alive", "dead", "unknown"]
    let genderCharacters = ["female", "male", "genderless", "unknown"]
    var statusIndexPath: IndexPath?
    var genderIndexPath: IndexPath?
}

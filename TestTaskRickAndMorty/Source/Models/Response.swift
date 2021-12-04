//
//  Response.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let info: Info
    let results: [T]
}

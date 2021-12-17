//
//  Episode.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let created: Date
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, created, url
        case airDate = "air_date"
    }
}
//MARK: - LocationURLParameters
struct EpisodeURLParameters: Decodable {
    var page: String?
    var name: String?
}

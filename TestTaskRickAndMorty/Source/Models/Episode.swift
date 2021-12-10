//
//  Episode.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import Foundation

struct Episode: Decodable, Hashable {
    var uuid = UUID()
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let created: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, created
        case airDate = "air_date"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
//MARK: - LocationURLParameters
struct EpisodeURLParameters: Decodable {
    var page: String?
    var name: String?
}

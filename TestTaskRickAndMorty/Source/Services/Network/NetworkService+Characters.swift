//
//  NetworkService+Characters.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    func requestCharacters(with params: CharacterURLParameters, and completion: @escaping (Result<Response<Character>, Error>) -> Void) {
        let url = URLFactory.getCharacter(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestLocations(with params: LocationURLParameters, and completion: @escaping (Result<Response<Location>, Error>) -> Void) {
        let url = URLFactory.getLocation(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestEpisodes(with params: EpisodeURLParameters, and completion: @escaping (Result<Response<Episode>, Error>) -> Void) {
        let url = URLFactory.getEpisode(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestEpisode(with url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
    
    func requestCharacter(with url: String, completion: @escaping (Result<Character, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
}

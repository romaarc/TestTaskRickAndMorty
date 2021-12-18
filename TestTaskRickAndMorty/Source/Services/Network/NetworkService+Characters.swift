//
//  NetworkService+Characters.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

extension NetworkService: NetworkServiceProtocol {
    func fetchCharacters(with params: CharacterURLParameters, and completion: @escaping (Result<Response<Character>, Error>) -> Void) {
        let url = URLFactory.getCharacter(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func fetchLocations(with params: LocationURLParameters, and completion: @escaping (Result<Response<Location>, Error>) -> Void) {
        let url = URLFactory.getLocation(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func fetchEpisodes(with params: EpisodeURLParameters, and completion: @escaping (Result<Response<Episode>, Error>) -> Void) {
        let url = URLFactory.getEpisode(params: params)
        self.baseRequest(url: url, completion: completion)
    }
    
    func fetchEpisode(with url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
    
    func fetchCharacter(with url: String, completion: @escaping (Result<Character, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
    
    func fetchLocation(with url: String, completion: @escaping (Result<Location, Error>) -> Void) {
        self.baseRequest(url: url, completion: completion)
    }
}

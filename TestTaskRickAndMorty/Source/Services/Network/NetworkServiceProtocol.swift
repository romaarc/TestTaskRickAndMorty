//
//  NetworkServiceProtocol.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCharacters(with params: CharacterURLParameters, and completion: @escaping (Result<Response<Character>, Error>) -> Void)
    func fetchLocations(with params: LocationURLParameters, and completion: @escaping (Result<Response<Location>, Error>) -> Void)
    func fetchEpisodes(with params: EpisodeURLParameters, and completion: @escaping (Result<Response<Episode>, Error>) -> Void)
    
    func fetchEpisode(with url: String, completion: @escaping (Result<Episode, Error>) -> Void)
    func fetchCharacter(with url: String, completion: @escaping (Result<Character, Error>) -> Void)
    func fetchLocation(with url: String, completion: @escaping (Result<Location, Error>) -> Void)
}

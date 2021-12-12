//
//  NetworkServiceProtocol.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func requestCharacters(with params: CharacterURLParameters, and completion: @escaping (Result<Response<Character>, Error>) -> Void)
    func requestLocations(with params: LocationURLParameters, and completion: @escaping (Result<Response<Location>, Error>) -> Void)
    func requestEpisodes(with params: EpisodeURLParameters, and completion: @escaping (Result<Response<Episode>, Error>) -> Void)
    func requestEpisode(with url: String, completion: @escaping (Result<Episode, Error>) -> Void)
}

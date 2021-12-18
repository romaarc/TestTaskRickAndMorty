//
//  PersistentProviderProtocol.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 16.12.2021.
//

import Foundation

protocol PersistentProviderProtocol {
    //MARK: - Character
    func update(with page: Int, where models: [Character],
                to action: PersistentState,
             and completion: @escaping (Result<PersistentState, Error>) -> Void)
    func fetchCharactersModels() -> [CharacterCDModel]
    func fetchCharactersModels(with page: Int) -> [CharacterCDModel]
    func fetchCharactersModels(with params: CharacterURLParameters) -> [CharacterCDModel]
    func fetchCharactersModels(by urls: [String]) -> [CharacterCDModel]
    
    //MARK: - Info
    func update(with page: Int, and count: Int, where action: PersistentInfo)
    func fetchInfoModels() -> [InfoCDModel]
    
    //MARK: - Location
    func fetchLocationModels(with page: Int) -> [LocationCDModel]
    func fetchLocationModel(by url: String) -> [LocationCDModel]
    func update(with page: Int, where models: [Location], and action: PersistentState)
    
    //MARK: - Episode
    func fetchEpisodeModels(with page: Int) -> [EpisodeCDModel]
    func fetchEpisodeModels(by urls: [String]) -> [EpisodeCDModel]
    func update(with page: Int, where models: [Episode], and action: PersistentState)
}

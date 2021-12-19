//
//  EpisodeTest.swift
//  TestTaskRickAndMortyTests
//
//  Created by Roman Gorshkov on 19.12.2021.
//

import XCTest
@testable import TestTaskRickAndMorty

class EpisodeInteractorTest: XCTestCase {
    var interactor: EpisodeInteractorInput?
    var networkService: NetworkServiceProtocol?
    override func setUp() {
        interactor = EpisodeInteractor(rickAndMortyNetworkService: FakeNetworkManager(), reachabilityService: FakeReachability(isReachable: true), persistentProvider: FakePersistentProvider())
        
    }

    override func tearDownWithError() throws {
        interactor = nil
    }
    
    func testFetchEpisode() {
        interactor?.reload()
    }

}

class MockPresenter: EpisodeInteractorOutput {
    var view: MockView!
    private var isNextPageLoading = false
    private var isReloading = false
    private var episodes: [Episode] = []
    private var dictEpisodes: [Int: Int] = [:]
    private var count: Int = 0
    
    func didLoad(with episodes: [Episode], loadType: LoadingDataType, count: Int) {
        switch loadType {
        case .reload:
            isReloading = false
            self.episodes = episodes
        case .nextPage:
            isNextPageLoading = false
            self.episodes.append(contentsOf: episodes)
        }
        let episodesSeason = self.episodes.map({ String($0.episode.dropLast(3)) })
        let seasons = Array(Set(episodesSeason)).sorted()
        for (index, season) in seasons.enumerated() {
            dictEpisodes[index] = episodesSeason.filter({ $0.contains(season) }).count
        }
        self.count = count
        let viewModels: [EpisodeViewModel] = MockPresenter.makeViewModels(self.episodes)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels, seasons: dictEpisodes)
    }
}

extension MockPresenter {
    static func makeViewModels(_ episodes: [Episode]) -> [EpisodeViewModel] {
        return episodes.map { epi in
            EpisodeViewModel(id: epi.id,
                             name: epi.name,
                             airDate: epi.airDate,
                             episode: epi.episode,
                             characters: epi.characters,
                             created: epi.created)
        }
    }
}


class MockView: EpisodeViewInput {
    private var viewModels: [EpisodeViewModel] = []
    private var seasons: [Int: Int] = [:]
    var expectation: XCTestExpectation?
    
    func set(viewModels: [EpisodeViewModel], seasons: [Int : Int]) {
        XCTAssertEqual(viewModels.count, 1)
        XCTAssertEqual(seasons.count, 1)
        expectation?.fulfill()
    }
    
    func stopActivityIndicator() {}
    func startActivityIndicator() {}
}

class FakeReachability: ReachabilityProtocol {
    var isReachable: Bool

    init(isReachable: Bool) {
        self.isReachable = isReachable
    }
    
    func isConnectedToNetwork() -> Bool {
        true
    }
}

class FakeNetworkManager: NetworkServiceProtocol {
    func fetchCharacters(with params: CharacterURLParameters, and completion: @escaping (Result<Response<Character>, Error>) -> Void) {
        completion(.failure(NetworkErrors.dataIsEmpty))
    }
    
    func fetchLocations(with params: LocationURLParameters, and completion: @escaping (Result<Response<Location>, Error>) -> Void) {
        completion(.failure(NetworkErrors.dataIsEmpty))
    }
    
    func fetchEpisodes(with params: EpisodeURLParameters, and completion: @escaping (Result<Response<Episode>, Error>) -> Void) {
        let characters = ["https://rickandmortyapi.com/api/character/1"]
        let episode: [Episode] = [Episode(id: 7,
                              name: "test test",
                              airDate: "September 10, 2017",
                              episode: "S03E07",
                              characters: characters,
                              created: Date(),
                              url: "https://rickandmortyapi.com/api/episode/7")]
       
        let info = Info(count: 1, pages: 1, next: "", prev: "")
        
        let results = Response(info: info, results: episode)
        
        completion(.success(results))
    }
    
    func fetchEpisode(with url: String, completion: @escaping (Result<Episode, Error>) -> Void) {
        completion(.failure(NetworkErrors.dataIsEmpty))
    }
    
    func fetchCharacter(with url: String, completion: @escaping (Result<Character, Error>) -> Void) {
        completion(.failure(NetworkErrors.dataIsEmpty))
    }
    
    func fetchLocation(with url: String, completion: @escaping (Result<Location, Error>) -> Void) {
        completion(.failure(NetworkErrors.dataIsEmpty))
    }
}

class FakePersistentProvider: PersistentProviderProtocol {
    func update(with page: Int, where models: [Character], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void) {
        return
    }
    
    func fetchCharactersModels() -> [CharacterCDModel] {
        return [CharacterCDModel]()
    }
    
    func fetchCharactersModels(with page: Int) -> [CharacterCDModel] {
        return [CharacterCDModel]()
    }
    
    func fetchCharactersModels(with params: CharacterURLParameters) -> [CharacterCDModel] {
        return [CharacterCDModel]()
    }
    
    func fetchCharactersModels(by urls: [String]) -> [CharacterCDModel] {
        return [CharacterCDModel]()
    }
    
    func update(with page: Int, and count: Int, where action: PersistentInfo) {
        return
    }
    
    func fetchInfoModels() -> [InfoCDModel] {
        return [InfoCDModel]()
    }
    
    func fetchLocationModels(with page: Int) -> [LocationCDModel] {
        return [LocationCDModel]()
    }
    
    func fetchLocationModel(by url: String) -> [LocationCDModel] {
        return [LocationCDModel]()
    }
    
    func update(with page: Int, where models: [Location], and action: PersistentState) {
        return
    }
    
    func fetchEpisodeModels(with page: Int) -> [EpisodeCDModel] {
        return [EpisodeCDModel]()
    }
    
    func fetchEpisodeModels(by urls: [String]) -> [EpisodeCDModel] {
        return [EpisodeCDModel]()
    }
    
    func update(with page: Int, where models: [Episode], and action: PersistentState) {
        return
    }
}



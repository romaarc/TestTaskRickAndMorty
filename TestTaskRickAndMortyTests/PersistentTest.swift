//
//  PersistentTest.swift
//  TestTaskRickAndMortyTests
//
//  Created by Roman Gorshkov on 19.12.2021.
//

import XCTest
@testable import TestTaskRickAndMorty

class PersistentTest: XCTestCase {

    var persistentProvider: PersistentProviderProtocol?
    
    override func setUpWithError() throws {
        persistentProvider = PersistentProvider()
    }

    override func tearDownWithError() throws {
        persistentProvider = nil
    }
    
    func testPersistentRequestCharactersModels() throws {
        //Given
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchCharactersModels()
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentRequestCharactersWithURLs() throws {
        //Given
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        let urls = ["https://rickandmortyapi.com/api/character/2",
                    "https://rickandmortyapi.com/api/character/3"]
        //When
        let cdModels = persistentProvider?.fetchCharactersModels(by: urls)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentRequestCharactersByPage() throws {
        //Given
        let page = GlobalConstants.initialPage
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchCharactersModels(with: page)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentRequestCharactersByParams() throws {
        //Given
        let params = CharacterURLParameters(page: "1", name: "Morty", status: "", gender: "")
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchCharactersFilterModels(with: params, and: 1)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentRequestInfo() throws {
        //Given
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchInfoModels()
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentEpisodesByPage() throws {
        //Given
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchEpisodeModels(with: 1)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentEpisodes() throws {
        //Given
        let urls = ["https://rickandmortyapi.com/api/episode/1",
                    "https://rickandmortyapi.com/api/episode/2"]
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchEpisodeModels(by: urls)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentLocationByURL() throws {
        //Given
        let url = "https://rickandmortyapi.com/api/location/1"
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchLocationModel(by: url)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPersistentLocationByPage() throws {
        //Given
        let expectation = XCTestExpectation(description: "Get all cd models from storage")
        //When
        let cdModels = persistentProvider?.fetchLocationModels(with: 1)
        guard let cdModels = cdModels else { return }
        print(cdModels)
        expectation.fulfill()
        //Then
        wait(for: [expectation], timeout: 2.0)
    }
}
                              



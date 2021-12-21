//
//  NetworkTests.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 19.12.2021.
//

import XCTest
@testable import TestTaskRickAndMorty

class NetworkTests: XCTestCase {
    var networkService: NetworkServiceProtocol?
    
    override func setUpWithError() throws {
        networkService = NetworkService(customDecoder: JSONDecoderCustom(),
                                        reachability: Reachability())
    }

    override func tearDownWithError() throws {
        networkService = nil
    }
    
    func testNetworkRequestByCharacters() throws {
        //Given
        let page = GlobalConstants.initialPage
        let parametersURL = CharacterURLParameters(page: String(page))
        let expectation = XCTestExpectation(description: "Perform network request characters with given parameters")
        
        //When
        networkService?.fetchCharacters(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 5.5)
    }
    
    func testNetworkRequestByCharactersError() {
        let page = GlobalConstants.initialPage + 999
        let parametersURL = CharacterURLParameters(page: String(page))
        let expectation = XCTestExpectation(description: "Test for error handling in request by method")
        
        networkService?.fetchCharacters(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 10)
    }
    
    func testNetworkRequestByLocations() throws {
        //Given
        let page = GlobalConstants.initialPage
        let parametersURL = LocationURLParameters(page: String(page), name: nil)
        let expectation = XCTestExpectation(description: "Perform network request locations with given parameters")
        
        //When
        networkService?.fetchLocations(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testNetworkRequestByLocationsError() throws {
        //Given
        let page = GlobalConstants.initialPage + 10000
        let parametersURL = LocationURLParameters(page: String(page), name: "nil")
        let expectation = XCTestExpectation(description: "Test for error handling in request by method")
        
        //When
        networkService?.fetchLocations(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }

    func testNetworkRequestByEpisodes() throws {
        //Given
        let page = GlobalConstants.initialPage
        let parametersURL = EpisodeURLParameters(page: String(page), name: "")
        let expectation = XCTestExpectation(description: "Perform network request episodes with given parameters")
        
        //When
        networkService?.fetchEpisodes(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testNetworkRequestByEpisodesError() throws {
        //Given
        let page = GlobalConstants.initialPage + 10000
        let parametersURL = EpisodeURLParameters(page: String(page), name: "nil")
        let expectation = XCTestExpectation(description: "Perform network request episodes with given parameters")
        
        //When
        networkService?.fetchEpisodes(with: parametersURL, and: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testNetworkRequestByCharacter() throws {
        //Given
        let url = "https://rickandmortyapi.com/api/character/2"
        let expectation = XCTestExpectation(description: "Perform network request character with given parameters")
        
        //When
        networkService?.fetchCharacter(with: url, completion: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 5.5)
    }
    
    func testNetworkRequestByLocation() throws {
        //Given
        let url = "https://rickandmortyapi.com/api/location/2"
        let expectation = XCTestExpectation(description: "Perform network request location with given parameters")
        
        //When
        networkService?.fetchLocation(with: url, completion: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 5.5)
    }
    
    func testNetworkRequestByEpisode() throws {
        //Given
        let url = "https://rickandmortyapi.com/api/episode/7"
        let expectation = XCTestExpectation(description: "Perform network request episode with given parameters")
        
        //When
        networkService?.fetchEpisode(with: url, completion: { result in
            switch result {
            case .success(_):
                print("Data received")
                expectation.fulfill()
            case .failure(_):
                break
            }
        })
        //Then
        wait(for: [expectation], timeout: 5.5)
    }
    
    func testNetworkRequestByCharacterError() throws {
        //Given
        let url = ""
        let expectation = XCTestExpectation(description: "Test for error handling in request by method")
        
        //When
        networkService?.fetchCharacter(with: url, completion: { result in
            switch result {
            case .success(_):
               break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testNetworkRequestByEpisodeError() throws {
        //Given
        let url = ""
        let expectation = XCTestExpectation(description: "Test for error handling in request by method")
        
        //When
        networkService?.fetchEpisode(with: url, completion: { result in
            switch result {
            case .success(_):
               break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testNetworkRequestByLocationError() throws {
        //Given
        let url = ""
        let expectation = XCTestExpectation(description: "Test for error handling in request by method")
        
        //When
        networkService?.fetchLocation(with: url, completion: { result in
            switch result {
            case .success(_):
               break
            case .failure(let error):
                print(error)
                expectation.fulfill()
            }
        })
        //Then
        wait(for: [expectation], timeout: 1.5)
    }
}

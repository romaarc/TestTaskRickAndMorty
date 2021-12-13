//
//  URLFactory.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

enum URLFactory {
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func getCharacter(params: CharacterURLParameters) -> String {
        var urlComponents = baseURLComponents
        let paramsQueryItem = [
            URLQueryItem(name: "page", value: params.page ?? ""),
            URLQueryItem(name: "name", value:  params.name ?? ""),
            URLQueryItem(name: "status", value: params.status ?? ""),
            URLQueryItem(name: "gender", value: params.gender ?? "")
        ]
        urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        return urlComponents.url!.appendingPathComponent(API.TypeOf.characters).absoluteString
    }
    
    static func getLocation(params: LocationURLParameters) -> String {
        var urlComponents = baseURLComponents
        let paramsQueryItem = [
            URLQueryItem(name: "page", value: params.page ?? ""),
            URLQueryItem(name: "name", value:  params.name ?? "")
        ]
        urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        return urlComponents.url!.appendingPathComponent(API.TypeOf.locations).absoluteString
    }
    
    static func getEpisode(params: EpisodeURLParameters) -> String {
        var urlComponents = baseURLComponents
        let paramsQueryItem = [
            URLQueryItem(name: "page", value: params.page ?? ""),
            URLQueryItem(name: "name", value:  params.name ?? "")
        ]
        urlComponents.queryItems?.append(contentsOf: paramsQueryItem)
        return urlComponents.url!.appendingPathComponent(API.TypeOf.episodes).absoluteString
    }
}

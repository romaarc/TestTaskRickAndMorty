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
}

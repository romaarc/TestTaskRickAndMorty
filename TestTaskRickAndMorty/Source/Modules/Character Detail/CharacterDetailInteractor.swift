//
//  CharacterDetailInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class CharacterDetailInteractor {
	weak var output: CharacterDetailInteractorOutput?
}

extension CharacterDetailInteractor: CharacterDetailInteractorInput {}

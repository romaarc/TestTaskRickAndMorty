//
//  CharacterInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation

final class CharacterInteractor {
	weak var output: CharacterInteractorOutput?
}

extension CharacterInteractor: CharacterInteractorInput {
}

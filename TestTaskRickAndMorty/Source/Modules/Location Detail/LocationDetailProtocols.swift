//
//  LocationDetailProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

protocol LocationDetailModuleInput {
	var moduleOutput: LocationDetailModuleOutput? { get }
}

protocol LocationDetailModuleOutput: AnyObject {
}

protocol LocationDetailViewInput: AnyObject {
}

protocol LocationDetailViewOutput: AnyObject {
}

protocol LocationDetailInteractorInput: AnyObject {
}

protocol LocationDetailInteractorOutput: AnyObject {
}

protocol LocationDetailRouterInput: AnyObject {
}

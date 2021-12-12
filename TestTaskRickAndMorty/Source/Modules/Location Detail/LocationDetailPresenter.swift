//
//  LocationDetailPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

final class LocationDetailPresenter {
	weak var view: LocationDetailViewInput?
    weak var moduleOutput: LocationDetailModuleOutput?
    
	private let router: LocationDetailRouterInput
	private let interactor: LocationDetailInteractorInput
    
    init(router: LocationDetailRouterInput, interactor: LocationDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationDetailPresenter: LocationDetailModuleInput {
}

extension LocationDetailPresenter: LocationDetailViewOutput {
}

extension LocationDetailPresenter: LocationDetailInteractorOutput {
}

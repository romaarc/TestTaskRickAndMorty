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
    private var residents: [Character] = []
    
	private let router: LocationDetailRouterInput
	private let interactor: LocationDetailInteractorInput
    
    init(router: LocationDetailRouterInput, interactor: LocationDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationDetailPresenter: LocationDetailModuleInput {}

extension LocationDetailPresenter: LocationDetailViewOutput {
    func viewDidLoad(with residents: [String]) {
        view?.startActivityIndicator()
        interactor.reload(by: residents)
    }
}

extension LocationDetailPresenter: LocationDetailInteractorOutput {
    func didLoad(with residents: [Character]) {
        let viewModels: [CharacterViewModel] = CharacterPresenter.makeViewModels(residents)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}

//
//  LocationPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class LocationPresenter {
	weak var view: LocationViewInput?
    weak var moduleOutput: LocationModuleOutput?
    
	private let router: LocationRouterInput
	private let interactor: LocationInteractorInput
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var hasNextPage = true
    private var locations: [Location] = []
    private var count: Int = 0
    
    init(router: LocationRouterInput, interactor: LocationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationPresenter: LocationModuleInput {}

extension LocationPresenter: LocationViewOutput {
    func viewDidLoad() {
        view?.startActivityIndicator()
        isReloading = true
        interactor.reload()
    }
    
    func loadNext() {
        view?.startActivityIndicator()
        isNextPageLoading = true
        interactor.loadNext()
    }
    
    func willDisplay(at index: Int) {
        guard !isReloading, !isNextPageLoading, index == (locations.count - 1), index >= 19, locations.count != self.count else {
            return
        }
        isNextPageLoading = true
        view?.startActivityIndicator()
        interactor.loadNext()
    }
    
    func onCellTap(with viewModel: LocationViewModel) {
        router.showDetail(with: viewModel)
    }
}

extension LocationPresenter: LocationInteractorOutput {
    func didLoad(with locations: [Location], loadType: LoadingDataType, count: Int) {
        switch loadType {
        case .reload:
            isReloading = false
            self.locations = locations
        case .nextPage:
            isNextPageLoading = false
            hasNextPage = locations.count > 0
            self.locations.append(contentsOf: locations)
        }
        self.count = count
        let viewModels: [LocationViewModel] = makeViewModels(self.locations)
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

private extension LocationPresenter {
    func makeViewModels(_ locations: [Location]) -> [LocationViewModel] {
        return locations.map { location in
            LocationViewModel(id: location.id,
                              name: location.name,
                              type: location.type,
                              dimension: location.dimension,
                              created: location.created)
        }
    }
}

//
//  LocationContainer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class LocationContainer {
    let input: LocationModuleInput
	let viewController: UIViewController
	private(set) weak var router: LocationRouterInput!

	static func assemble(with context: LocationContext) -> LocationContainer {
        let router = LocationRouter()
        let interactor = LocationInteractor(rickAndMortyNetworkService: context.moduleDependencies.rickAndMortyNetworkService,
                                            reachabilityService: context.moduleDependencies.reachabilityService, persistentProvider: context.moduleDependencies.persistentProvider)
        let presenter = LocationPresenter(router: router, interactor: interactor)
		let viewController = LocationViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        
        router.viewControllerProvider = { [weak viewController] in
            viewController
        }
        router.navigationControllerProvider = { [weak viewController] in
            viewController?.navigationController
        }
        
        router.moduleDependencies = context.moduleDependencies

        return LocationContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LocationModuleInput, router: LocationRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LocationContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: LocationModuleOutput?
}

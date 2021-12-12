//
//  LocationDetailContainer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import UIKit

final class LocationDetailContainer {
    let input: LocationDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: LocationDetailRouterInput!

	static func assemble(with context: LocationDetailContext) -> LocationDetailContainer {
        let router = LocationDetailRouter()
        let interactor = LocationDetailInteractor()
        let presenter = LocationDetailPresenter(router: router, interactor: interactor)
		let viewController = LocationDetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return LocationDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: LocationDetailModuleInput, router: LocationDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct LocationDetailContext {
	weak var moduleOutput: LocationDetailModuleOutput?
}

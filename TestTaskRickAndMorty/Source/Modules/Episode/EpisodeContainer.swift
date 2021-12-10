//
//  EpisodeContainer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class EpisodeContainer {
    let input: EpisodeModuleInput
	let viewController: UIViewController
	private(set) weak var router: EpisodeRouterInput!

	static func assemble(with context: EpisodeContext) -> EpisodeContainer {
        let router = EpisodeRouter()
        let interactor = EpisodeInteractor(rickAndMortyNetworkService: context.moduleDependencies.rickAndMortyNetworkService)
        let presenter = EpisodePresenter(router: router, interactor: interactor)
		let viewController = EpisodeViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EpisodeContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EpisodeModuleInput, router: EpisodeRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EpisodeContext {
    typealias ModuleDependencies = HasNetworkService
    let moduleDependencies: ModuleDependencies
	weak var moduleOutput: EpisodeModuleOutput?
}

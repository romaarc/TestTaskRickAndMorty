//
//  EpisodeDetailContainer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import UIKit

final class EpisodeDetailContainer {
    let input: EpisodeDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: EpisodeDetailRouterInput!

	static func assemble(with context: EpisodeDetailContext) -> EpisodeDetailContainer {
        let router = EpisodeDetailRouter()
        let interactor = EpisodeDetailInteractor()
        let presenter = EpisodeDetailPresenter(router: router, interactor: interactor)
		let viewController = EpisodeDetailViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return EpisodeDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EpisodeDetailModuleInput, router: EpisodeDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EpisodeDetailContext {
	weak var moduleOutput: EpisodeDetailModuleOutput?
}

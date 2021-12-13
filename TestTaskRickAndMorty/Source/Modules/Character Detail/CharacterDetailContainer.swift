//
//  CharacterDetailContainer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class CharacterDetailContainer {
    let input: CharacterDetailModuleInput
	let viewController: UIViewController
	private(set) weak var router: CharacterDetailRouterInput!

    static func assemble(with context: CharacterDetailContext, withModel viewModel: CharacterViewModel) -> CharacterDetailContainer {
        let router = CharacterDetailRouter()
        let interactor = CharacterDetailInteractor(rickAndMortyNetworkService: context.moduleDependencies.rickAndMortyNetworkService)
        let presenter = CharacterDetailPresenter(router: router, interactor: interactor)
        let viewController = CharacterDetailViewController(output: presenter, viewModel: viewModel)

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

        return CharacterDetailContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: CharacterDetailModuleInput, router: CharacterDetailRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct CharacterDetailContext {
    let moduleDependencies: ModuleDependencies
    weak var moduleOutput: CharacterDetailModuleOutput?
}

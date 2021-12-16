//
//  CharacterRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import UIKit

final class CharacterRouter: BaseRouter {}

extension CharacterRouter: CharacterRouterInput {
    
    func showDetail(with viewModel: CharacterViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = CharacterDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = CharacterDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func showFilter(with filter: Filter) {
        let filterVC = CharacterFilterViewController(filter: filter)
        filterVC.delegate = self.viewController as? CharacterFilterDelegate
        filterVC.transitioningDelegate = transition
        filterVC.modalPresentationStyle = .custom
        viewController?.present(filterVC, animated: true)
    }
}

extension CharacterRouter: CharacterDetailModuleOutput {}

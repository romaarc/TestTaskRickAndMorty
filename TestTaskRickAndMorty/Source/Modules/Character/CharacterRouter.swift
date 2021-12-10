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
        let context = CharacterDetailContext(moduleOutput: self)
        let container = CharacterDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func showFilter(withStatus status: String, withGender gender: String) {
        let filterVC = CharacterFilterViewController(currentStatus: status, currentGender: gender)
        filterVC.delegate = self.viewController as? CharacterFilterDelegate
        filterVC.transitioningDelegate = transition
        filterVC.modalPresentationStyle = .custom
        viewController?.present(filterVC, animated: true)
    }
}

extension CharacterRouter: CharacterDetailModuleOutput {}

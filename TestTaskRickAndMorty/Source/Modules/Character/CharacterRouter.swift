//
//  CharacterRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import UIKit

final class CharacterRouter {
    private let transition = PanelTransition()
    var viewController: UIViewController?
}

extension CharacterRouter: CharacterRouterInput {
    func showFilter(withStatus status: String, withGender gender: String) {
        let child = CharacterFilterViewController(currentStatus: status, currentGender: gender)
        child.delegate = viewController as? CharacterFilterDelegate
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        viewController?.present(child, animated: true)
    }
}

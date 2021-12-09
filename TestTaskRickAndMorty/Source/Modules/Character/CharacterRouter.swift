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
    func showFilter() {
        let child = UIViewController()
        child.view.backgroundColor = .white
        child.view.layer.cornerRadius = 24
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        viewController?.present(child, animated: true)
    }
}

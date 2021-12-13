//
//  BaseRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import UIKit

class BaseRouter {
    lazy var transition = PanelTransition()
    var moduleDependencies: ModuleDependencies?
    
    var navigationControllerProvider: (() -> UINavigationController?)?
    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }
    
    var viewControllerProvider: (() -> UIViewController?)?
    var viewController: UIViewController? {
        self.viewControllerProvider?()
    }
}

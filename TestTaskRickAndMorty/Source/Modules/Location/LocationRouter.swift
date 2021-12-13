//
//  LocationRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class LocationRouter: BaseRouter {}

extension LocationRouter: LocationRouterInput {
    func showDetail(with viewModel: LocationViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = LocationDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = LocationDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension LocationRouter: LocationDetailModuleOutput {}

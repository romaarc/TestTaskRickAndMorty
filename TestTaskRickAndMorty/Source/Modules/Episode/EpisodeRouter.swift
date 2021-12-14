//
//  EpisodeRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class EpisodeRouter: BaseRouter {}

extension EpisodeRouter: EpisodeRouterInput {
    func showDetail(with viewModel: EpisodeViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = EpisodeDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = EpisodeDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension EpisodeRouter: EpisodeDetailModuleOutput {}

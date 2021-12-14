//
//  CharacterDetailRouter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class CharacterDetailRouter: BaseRouter {}

extension CharacterDetailRouter: CharacterDetailRouterInput {
    func showLocation(with location: LocationViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = LocationDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = LocationDetailContainer.assemble(with: context, withModel: location)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
    
    func showEpisode(with viewModel: EpisodeViewModel) {
        guard let moduleDependencies = moduleDependencies else { return }
        let context = EpisodeDetailContext(moduleDependencies: moduleDependencies, moduleOutput: self)
        let container = EpisodeDetailContainer.assemble(with: context, withModel: viewModel)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension CharacterDetailRouter: LocationDetailModuleOutput {}
extension CharacterDetailRouter: EpisodeDetailModuleOutput {}

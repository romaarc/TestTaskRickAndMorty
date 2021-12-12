//
//  EpisodeDetailPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

final class EpisodeDetailPresenter {
	weak var view: EpisodeDetailViewInput?
    weak var moduleOutput: EpisodeDetailModuleOutput?
    
	private let router: EpisodeDetailRouterInput
	private let interactor: EpisodeDetailInteractorInput
    
    init(router: EpisodeDetailRouterInput, interactor: EpisodeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EpisodeDetailPresenter: EpisodeDetailModuleInput {
}

extension EpisodeDetailPresenter: EpisodeDetailViewOutput {
}

extension EpisodeDetailPresenter: EpisodeDetailInteractorOutput {
}

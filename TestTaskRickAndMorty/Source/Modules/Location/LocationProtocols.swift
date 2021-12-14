//
//  LocationProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

protocol LocationModuleInput {
	var moduleOutput: LocationModuleOutput? { get }
}

protocol LocationModuleOutput: AnyObject {}

protocol LocationViewInput: ViewInput {
    func set(viewModels: [LocationViewModel])
}

protocol LocationViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int)
    func onCellTap(with viewModel: LocationViewModel)
}

protocol LocationInteractorInput: InteractorInput {}

protocol LocationInteractorOutput: InteractorOutput {
    func didLoad(with locations: [Location], loadType: LoadingDataType, count: Int)
}

protocol LocationRouterInput: AnyObject {
    func showDetail(with viewModel: LocationViewModel)
}

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

protocol LocationViewInput: AnyObject {
    func set(viewModels: [LocationViewModel])
    func stopActivityIndicator()
    func startActivityIndicator()
    func didError()
}

protocol LocationViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int)
    func onCellTap(with viewModel: LocationViewModel)
}

protocol LocationInteractorInput: AnyObject {
    func reload()
    func loadNext()
}

protocol LocationInteractorOutput: AnyObject {
    func didLoad(with locations: [Location], loadType: LoadingDataType, count: Int)
    func didError(with error: Error)
}

protocol LocationRouterInput: AnyObject {
    func showDetail(with viewModel: LocationViewModel)
}

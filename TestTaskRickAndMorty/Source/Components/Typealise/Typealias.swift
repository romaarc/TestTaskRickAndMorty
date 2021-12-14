//
//  Typealias.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 14.12.2021.
//

import Foundation
//MARK: - For Dependencies
typealias ModuleDependencies = HasNetworkService
//MARK: - For VIPER
typealias ViewInput = AnyObject & Errorable & Indicator
typealias InteractorInput = AnyObject & Reloadable
typealias InteractorOutput = AnyObject & Errorable

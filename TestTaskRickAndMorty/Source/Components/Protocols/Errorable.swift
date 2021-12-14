//
//  Errorable.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 14.12.2021.
//

import Foundation

protocol Errorable {
    func didError()
    func didError(with error: Error)
}

extension Errorable {
    func didError(with error: Error) {}
    func didError() {}
}

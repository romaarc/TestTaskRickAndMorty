//
//  Localize.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit

enum Localize {
    static let characters = "Герои"
    static let favorites = "Избранное"
    
    enum Images {
        static let charactersIcon = UIImage(systemName: "person.3")!
        static let favoritesIcon = UIImage(systemName: "heart.circle.fill")!
        static let characterFilterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
    }
}


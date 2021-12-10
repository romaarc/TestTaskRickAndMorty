//
//  Localize.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit

enum Localize {
    static let characters = "Персонажи"
    static let locations = "Локации"
    static let episodes = "Эпизоды"
    
    enum Images {
        static let charactersIcon = UIImage(systemName: "person.3")!
        static let locationIcon = UIImage(systemName: "globe")!
        static let episodesIcon = UIImage(systemName: "tv")!
        static let characterFilterSymbol = UIImage(systemName: "line.horizontal.3.decrease.circle")
        static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
    }
}


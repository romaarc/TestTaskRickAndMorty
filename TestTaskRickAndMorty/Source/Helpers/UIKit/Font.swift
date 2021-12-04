//
//  Font.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit.UIFont

enum Font {
    enum Size {
        static let twenty: CGFloat = 20.0
        static let twentyEight: CGFloat = 28.0
        static let fouthteen: CGFloat = 14.0
        static let seventeen: CGFloat = 17.0
    }
    
    enum Weight {
        case regular, bold
    }
    
    static func sber(ofSize size: CGFloat, weight: Weight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "SBSansInterface-Regular", size: size)!
        case .bold:
            return UIFont(name: "SBSansDisplay-Semibold", size: size)!
        }
    }
}

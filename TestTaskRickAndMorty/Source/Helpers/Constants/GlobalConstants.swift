//
//  GlobalConstants.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit

struct GlobalConstants {
    static let initialPage = 1
}

struct CharacterDetailConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        static let tableDescriptionCellHeight: CGFloat = 105
        static let numberOfSections = 2
        static let locationCellIndex: Int = 3
        static let cellCount: Int = 4
    }
    
    struct Strings {
        static let headerInfo = "Информация"
        static let headerEpi = "Эпизоды"
        static let emptyMessage = "Не найдено эпизодов или локаций"
    }
}

struct CharacterConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 9
        static let spacingLeft: CGFloat = 9
        static let spacingTop: CGFloat = 9
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 23
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
    
    struct Strings {
        static let emptyMessageDidError = "Не найдено персонажей или подключитесь к сети, чтобы загрузить данные"
        static let emptyMessage = "Не найдено персонажей"
        static let searchBarPlaceholder = "Найти персонажа"
        static let UISearchBarTitle = "Отменить"
    }
}

struct LocationConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 80
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 16
        static let spacingLeft: CGFloat = 16
        static let spacingTop: CGFloat = 19
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 16
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
    
    struct Strings {
        static let emptyMessage = "Не найдено локаций или подключитесь к сети, чтобы загрузить данные"
    }
}

struct LocationDetailConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 16
        static let spacingLeft: CGFloat = 16
        static let spacingTop: CGFloat = 10
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 16
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Strings {
        static var headerInfo = "Резиденты"
        static let emptyMessage = "Не найдено резидентов"
    }
}

struct EpisodeConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 80
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 16
        static let spacingLeft: CGFloat = 16
        static let spacingTop: CGFloat = 19
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 16
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
        
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Strings {
        static var seasonTitle = "Сезон"
        static let emptyMessage = "Не найдено эпизодов или подключитесь к сети, чтобы загрузить данные"
    }
}

struct EpisodeDetailConstants {
    struct Layout {
        static let heightCardDescription: CGFloat = 79
        
        static let itemsInRow: CGFloat = 2
        
        static let spacing: CGFloat = 16
        static let spacingLeft: CGFloat = 16
        static let spacingTop: CGFloat = 10
        static let spacingBottom: CGFloat = 20
        static let spacingRight: CGFloat = 16
        static let minimumInteritemSpacingForSectionAt: CGFloat = 17
        
        static let cornerRadius: CGFloat = 8
    
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Strings {
        static var headerInfo = "Персонажи"
        static let emptyMessage = "Не найдено персонажей"
    }
}

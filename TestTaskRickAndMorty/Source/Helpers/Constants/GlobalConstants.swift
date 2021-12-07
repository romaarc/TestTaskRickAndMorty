//
//  GlobalConstants.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit

struct GlobalConstants {
    static let margin: CGFloat = 16
    static let circleText = "  ●  "
    static let collectionCellWidth = 342
    static let collectionCellHeight = 513
    static let raitingSlogan = "рейтинг: "
    static let initialPage = 1
}

//struct FavoriteConstants {
//    struct Layout {
//        static let tenSpace: CGFloat = 10
//        static let fifteenSpace: CGFloat = 15
//        static let titleHeightAnchor: CGFloat = 20
//        static let titleTrailingAnchor: CGFloat = -5
//        static let separatorInsetTop: CGFloat = 10
//        static let posterViewTopAnchor: CGFloat = 130
//        static let heightForRowAt: CGFloat = 200
//        static let cornerRadius: CGFloat = 15
//    }
//}
//
//struct DetailConstants {
//    struct Layout {
//        static let tableViewContentInsetTop: CGFloat = 40
//        static let numberOfSections: Int = 2
//        static let closeButtonImageInsets: CGFloat = 5
//        static let closeButtonX: CGFloat = 60
//        static let closeButtonY: CGFloat = 40
//        static let closeButtonWidthHeight: CGFloat = 45
//        static let size: CGFloat = 50
//        static let descriptionLabelWidth: CGFloat = 362
//        static let descriptionLabelY15: CGFloat = 15
//        static let descriptionLabelY30: CGFloat = 30
//        static let descriptionLabelX: CGFloat = 10
//        static let detailViewTitleLabelWidthAnchor: CGFloat = 310
//        static let detailViewTitleLabelHeightAnchor: CGFloat = 20
//    }
//
//    struct Images {
//        static let closeButtonImage = UIImage(systemName: "xmark.circle.fill")?.withTintColor(Colors.lightWhite).withRenderingMode(.alwaysOriginal)
//    }
//}
//
struct CharacterConstants {
    struct Layout {
        static let cornerRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 0.4
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
//    struct Images {
//        static let playButton = UIImage(systemName: "play.circle")?.withTintColor(UIColor.white)
//        static let starButton = UIImage(systemName: "star")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
//        static let starFillButton = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal)
//    }
}


//
//  CustomFlowLayout.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 07.12.2021.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let targetX: CGFloat = {
            let totalWidth = collectionViewContentSize.width
            
            if totalWidth > collectionView.bounds.size.width {
                return proposedContentOffset.x
            }
            return 0
        }()
        
        let targetY: CGFloat = {
            let totalHeight = collectionViewContentSize.height
            
            if totalHeight > collectionView.bounds.size.height {
                return proposedContentOffset.y
            }
            return 0
        }()
        
        return CGPoint(x: targetX, y: targetY)
    }
}

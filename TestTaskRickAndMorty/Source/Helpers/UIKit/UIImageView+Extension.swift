//
//  UIImageView+Extension.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
    
    func setImageOffline(with url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: [.fromMemoryCacheOrRefresh])
    }
}


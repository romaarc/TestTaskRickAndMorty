//
//  UIImageView+Extension.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?, isOffline: Bool) {
        let placeholder = UIImage(named: "default")
        self.kf.indicatorType = .activity
        if isOffline {
            self.kf.setImage(with: url, placeholder: placeholder, options: [.onlyFromCache])
        } else {
            self.kf.setImage(with: url, placeholder: placeholder)
        }
    }
    
    func setImageOffline(with url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "default"), options: [.onlyFromCache])
    }
}

//
//  Cacher.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import Kingfisher
import UIKit.UIImageView

extension UIImageView {
    func setupCache() {
        let cache = ImageCache.default
        // Limit memory cache size to 100 MB.
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024

        // Limit memory cache to hold 150 images at most.
        cache.memoryStorage.config.countLimit = 150
        
        // Limit disk cache size to 200 MB.
        cache.diskStorage.config.sizeLimit = 200 * 1024 * 1024
        
        // Memory image expires after 60 sec.
        cache.memoryStorage.config.expiration = .seconds(60)
    }
}


//
//  UIDevice+Extension.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 18.12.2021.
//

import UIKit
extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}

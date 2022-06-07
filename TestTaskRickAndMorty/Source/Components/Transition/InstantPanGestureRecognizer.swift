//
//  InstantPanGestureRecognizer.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 09.12.2021.
//

import UIKit

final class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}

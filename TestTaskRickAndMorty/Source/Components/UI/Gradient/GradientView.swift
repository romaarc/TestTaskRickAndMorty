//
//  GradientView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 07.12.2021.
//

import UIKit

final class GradientView: UIView {
    var topColor: UIColor = Colors.Gradient.midColor
    var midColor: UIColor = Colors.Gradient.topColor
    
    var startPointX: CGFloat = 0.1
    var startPointY: CGFloat = 0.1
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, midColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

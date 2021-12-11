//
//  UILabel+Extension.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 11.12.2021.
//

import UIKit.UILabel

class TopAlignedLabel: UILabel {
  override func drawText(in rect: CGRect) {
    let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
    super.drawText(in: textRect)
  }
}

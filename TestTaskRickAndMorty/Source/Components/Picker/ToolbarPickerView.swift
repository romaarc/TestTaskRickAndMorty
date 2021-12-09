//
//  ToolbarPickerView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 09.12.2021.
//

import Foundation
import UIKit

protocol ToolbarPickerViewDelegate: AnyObject {
    func didTapDone(_ pickerView: UIPickerView)
    func didTapCancel(_ pickerView: UIPickerView)
}

class ToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneTapped))
        doneButton.setTitleTextAttributes([
            .font : Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ], for: .normal)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelTapped))
        cancelButton.setTitleTextAttributes([
            .font : Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ], for: .normal)

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        toolbarDelegate?.didTapDone(self)
    }

    @objc func cancelTapped() {
        toolbarDelegate?.didTapCancel(self)
    }
}

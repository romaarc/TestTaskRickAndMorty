//
//  CharacterFilterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 09.12.2021.
//

import UIKit

protocol CharacterFilterDelegate: AnyObject {
    func didFilterTapped(status: String, gender: String)
    func didClearTapped()
}

class CharacterFilterViewController: UIViewController {
    
    weak var delegate: CharacterFilterDelegate?
    
    private let statusTextField: PickerTextField = {
        let field = PickerTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.placeholder = "Укажите статус"
        field.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 5
        field.textColor = .black
        return field
    }()
    
    private let genderTextField: PickerTextField = {
        let field = PickerTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.placeholder = "Укажите пол"
        field.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 5
        field.textColor = .black
        return field
    }()
    
    private let statusPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.tag = 1
        return picker
    }()
    
    private let genderPickerView: ToolbarPickerView = {
        let picker = ToolbarPickerView()
        picker.tag = 2
        return picker
    }()
    
    private let filterButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitle("Фильтр", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        return btn
    }()
    
    private let clearFilterButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitle("Очистить", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        return btn
    }()
    
    private let statusCharacters = ["alive", "dead", "unknown"]
    private let genderCharacters = ["female", "male", "genderless", "unknown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    init(currentStatus: String, currentGender: String) {
        super.init(nibName: nil, bundle: nil)
        
        if currentStatus != "" {
            self.statusTextField.text = currentStatus
        }
        
        if currentGender != "" {
            self.genderTextField.text = currentGender
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - CharacterFilterViewController
private extension CharacterFilterViewController {
    func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        
        statusTextField.inputView = statusPickerView
        statusTextField.inputAccessoryView = statusPickerView.toolbar
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = genderPickerView.toolbar
        
        [statusTextField, genderTextField, filterButton, clearFilterButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height * 0.03),
            statusTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.80),
            statusTextField.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.04),
            statusTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genderTextField.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: view.frame.size.height * 0.025),
            genderTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.80),
            genderTextField.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.04),
            genderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            filterButton.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant:  view.frame.size.height * 0.03),
            filterButton.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.80),
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.04),
            
            clearFilterButton.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant:  view.frame.size.height * 0.01),
            clearFilterButton.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.80),
            clearFilterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearFilterButton.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.04)
        ])
        
        [statusPickerView, genderPickerView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.toolbarDelegate = self
        }
    }
    
func setupButtons() {
        filterButton.addTarget(self, action: #selector(buttonFilterClicked), for: .touchUpInside)
        clearFilterButton.addTarget(self, action: #selector(buttonCleaFilterClicked), for: .touchUpInside)
    }
    
    @objc private func buttonFilterClicked() {
        let status = statusTextField.text ?? ""
        let gender = genderTextField.text ?? ""
        delegate?.didFilterTapped(status: status, gender: gender)
        dismiss(animated: true)
    }
    @objc private func buttonCleaFilterClicked() {
        delegate?.didClearTapped()
        dismiss(animated: true)
    }
}
// MARK: - UIPickerViewDataSource
extension CharacterFilterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return statusCharacters.count
        case 2:
            return genderCharacters.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return statusCharacters[row]
        case 2:
            return genderCharacters[row]
        default:
            return "Не найдено"
        }
    }
}
// MARK: - UIPickerViewDelegate
extension CharacterFilterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            statusTextField.text = statusCharacters[row]
        case 2:
            genderTextField.text = genderCharacters[row]
        default:
            return
        }
    }
}
// MARK: - ToolbarPickerViewDelegate
extension CharacterFilterViewController: ToolbarPickerViewDelegate {
    func didTapDone(_ pickerView: UIPickerView) {
        switch pickerView.tag {
        case 1:
            let row = pickerView.selectedRow(inComponent: 0)
            pickerView.selectRow(row, inComponent: 0, animated: false)
            statusTextField.text = statusCharacters[row]
            statusTextField.resignFirstResponder()
        case 2:
            let row = pickerView.selectedRow(inComponent: 0)
            pickerView.selectRow(row, inComponent: 0, animated: false)
            genderTextField.text = genderCharacters[row]
            genderTextField.resignFirstResponder()
        default:
            return
        }
        
    }
    
    func didTapCancel(_ pickerView: UIPickerView) {
        switch pickerView.tag {
        case 1:
            statusTextField.text = nil
            statusTextField.resignFirstResponder()
        case 2:
            genderTextField.text = nil
            genderTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
        switch pickerView.tag {
        case 1:
            label.text = statusCharacters[row]
        case 2:
            label.text = genderCharacters[row]
        default:
            return UIView()
        }
        return label
    }
}

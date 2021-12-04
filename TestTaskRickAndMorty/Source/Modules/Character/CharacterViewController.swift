//
//  CharacterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import UIKit

final class CharacterViewController: UIViewController {
	private let output: CharacterViewOutput
    private let searchController = UISearchController()

    init(output: CharacterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchController()
	}
}
//MARK: - CharacterViewInput from Presenter
extension CharacterViewController: CharacterViewInput {
}

//MARK: - Filter VC
private extension CharacterViewController {
    @objc func filterButtonClicked() {
    }
}

// MARK: - Search bar methods
extension CharacterViewController: UISearchBarDelegate {
    private func configureSearchController(){
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.characterFilterSymbol, style: .plain, target: self, action: #selector(filterButtonClicked))
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти героя"
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
    }

    private func setSearchController() {

    }
    
    private func getCharactersBySearchQuery(searchQuery: String) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

//
//  AppCoordinator.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = AppCoordinator.makeNavigationControllers()
    private let appDependency: AppDependency
    
    init(window: UIWindow, appDependency: AppDependency) {
        self.window = window
        self.appDependency = appDependency
        navigationControllers = AppCoordinator.makeNavigationControllers()
    }
    
    func start() {
        //Kingfisher method for clear cache images
        UIImageView().setupCache()
        
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        
        setupCharacter()
        setupLocation()
        setupEpisode()
        
        let navigationControllers = NavigationControllersType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        setupAppearanceTabBar(with: tabBarController)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    static func makeNavigationControllers() -> [NavigationControllersType: UINavigationController] {
        var result: [NavigationControllersType: UINavigationController] = [:]
        NavigationControllersType.allCases.forEach { navigationControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem: UITabBarItem = UITabBarItem(title: navigationControllerKey.title,
                                                        image: navigationControllerKey.image,
                                                        tag: navigationControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            navigationController.navigationBar.prefersLargeTitles = true
            //navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.sizeToFit()
            result[navigationControllerKey] = navigationController
        }
        return result
    }
    
    func setupCharacter() {
        guard let navController = self.navigationControllers[.characters] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = CharacterContext(moduleDependencies: appDependency, moduleOutput: nil)
        let container = CharacterContainer.assemble(with: context)
        let characterVC = container.viewController
        characterVC.navigationItem.title = Localize.characters
        navController.setViewControllers([characterVC], animated: false)
        setupAppearanceNavigationBar(with: navController)
    }
    
    func setupLocation() {
        guard let navController = self.navigationControllers[.locations] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = LocationContext(moduleDependencies: appDependency, moduleOutput: nil)
        let container = LocationContainer.assemble(with: context)
        let locationVC = container.viewController
        locationVC.navigationItem.title = Localize.locations
        navController.setViewControllers([locationVC], animated: false)
        setupAppearanceNavigationBar(with: navController)
    }
    
    func setupEpisode() {
        guard let navController = self.navigationControllers[.episodes] else {
            fatalError("something wrong with appCoordinator")
        }
        let context = EpisodeContext(moduleDependencies: appDependency, moduleOutput: nil)
        let container = EpisodeContainer.assemble(with: context)
        let episodeVC = container.viewController
        episodeVC.navigationItem.title = Localize.episodes
        navController.setViewControllers([episodeVC], animated: false)
        setupAppearanceNavigationBar(with: navController)
    }
    
    func setupAppearanceTabBar(with controller: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.backgroundColor = Colors.lightGray
        
        if #available(iOS 15.0, *) {
            controller.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        controller.tabBar.standardAppearance = tabBarAppearance
        controller.tabBar.unselectedItemTintColor = Colors.grayTabBar
        controller.selectedIndex = 0
        
        UITabBar.appearance().tintColor = Colors.purple
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        tabBarItemAppearance.selected.titleTextAttributes = [.font: Font.sber(ofSize: Font.Size.ten, weight: .bold)]
        
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: controller.tabBar.frame.width, y: 0))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = Colors.lightWhite.cgColor
        shapeLayer.lineWidth = 0.4

        controller.tabBar.layer.addSublayer(shapeLayer)
    }
    
    func setupAppearanceNavigationBar(with controller: UINavigationController) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Colors.lightGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                       .font : Font.sber(ofSize: Font.Size.twenty, weight: .bold)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font : Font.sber(ofSize: Font.Size.thirdyFour, weight: .bold),
                                                            .paragraphStyle: paragraphStyle,
                                                            .kern: 0.41]
        UINavigationBar.appearance().tintColor = Colors.purple
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
    }
}

fileprivate enum NavigationControllersType: Int, CaseIterable {
    case characters, locations, episodes
    var title: String {
        switch self {
        case .characters:
            return Localize.characters
        case .locations:
            return Localize.locations
        case .episodes:
            return Localize.episodes
        }
    }
    
    var image: UIImage {
        switch self {
        case .characters:
            return Localize.Images.charactersIcon
        case .locations:
            return Localize.Images.locationIcon
        case .episodes:
            return Localize.Images.episodesIcon
        }
    }
}

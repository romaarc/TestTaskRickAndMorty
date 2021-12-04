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
    //private lazy var persistentProvider = PersistentProvider()
    
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
        //setupFavorites()
        
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
    
    func setupAppearanceTabBar(with controller: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.backgroundColor = Colors.lightWhite
        
        if #available(iOS 15.0, *) {
            controller.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        controller.tabBar.standardAppearance = tabBarAppearance
        controller.tabBar.backgroundColor = Colors.lightWhite
        
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().tintColor = .black
        
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
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                       .font : Font.sber(ofSize: Font.Size.twenty, weight: .bold)]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font : Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)]
        controller.navigationBar.standardAppearance = navigationBarAppearance
        controller.navigationBar.compactAppearance = navigationBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

fileprivate enum NavigationControllersType: Int, CaseIterable {
    case characters, favorites
    var title: String {
        switch self {
        case .characters:
            return Localize.characters
        case .favorites:
            return Localize.favorites
        }
    }
    
    var image: UIImage {
        switch self {
        case .characters:
            return Localize.Images.moviesIcon
        case .favorites:
            return Localize.Images.favoritesIcon
        }
    }
}

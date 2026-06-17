//
//  AppRouter.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit

final class AppRouter {

    let navigationController = UINavigationController()

    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }
}

extension AppRouter {
    func start() -> UIViewController {
        let root = RootModuleBuilder.build(navigationController: navigationController, container: container)
        navigationController.viewControllers = [root]
        return navigationController
    }
}

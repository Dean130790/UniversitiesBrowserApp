//
//  SceneDelegate.swift
//  UniversitiesBrowserApp
//
//  Created by Yatharth Wadekar on 16/06/26.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let container = DependencyContainer()
}

extension SceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let appRouter = AppRouter(container: container)
        let root = appRouter.start()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = root
        window.makeKeyAndVisible()

        self.window = window
    }
}

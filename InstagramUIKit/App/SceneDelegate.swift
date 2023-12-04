//
//  SceneDelegate.swift
//  InstagramUIKit
//
//  Created by Maciej on 30/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: MainTabController())
        window?.rootViewController = navigationController
    }
}


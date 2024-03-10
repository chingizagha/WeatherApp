//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Chingiz on 07.03.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = MainViewController()
        window.rootViewController = UINavigationController(rootViewController: vc)
        self.window = window
        self.window?.makeKeyAndVisible()
    }



}


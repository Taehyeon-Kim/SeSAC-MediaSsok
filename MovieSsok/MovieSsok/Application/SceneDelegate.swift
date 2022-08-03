//
//  SceneDelegate.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let trendViewController = TrendViewController()
        window?.rootViewController = UINavigationController(rootViewController: trendViewController)
        window?.makeKeyAndVisible()
    }
}


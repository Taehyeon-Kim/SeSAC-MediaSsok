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
        
        let rootViewController = UIStoryboard(name: "CinemaViewController", bundle: nil).instantiateViewController(withIdentifier: "CinemaViewController")
        window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
        window?.makeKeyAndVisible()
    }
}


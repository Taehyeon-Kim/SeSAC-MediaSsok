//
//  MainTabBarController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/20.
//

import UIKit

final class MainTabBarController: BaseTabBarController {
    
    private let tabBarItems = TabStyle.allCases
    
    override func configure() {
        super.configure()
        
        let viewControllers = tabBarItems.map(createTabBarViewController(_:))
        tabBarItems.enumerated().forEach {
            viewControllers[$0].tabBarItem = $1.asTabBarItem()
        }
        setViewControllers(viewControllers, animated: true)
    }
}

extension MainTabBarController {
    
    private func createTabBarViewController(_ tabStyle: TabStyle) -> UIViewController {
        
        switch tabStyle {
        case .home:
            let controller = UIStoryboard(name: "HomeViewController", bundle: nil)
                .instantiateViewController(withIdentifier: "HomeViewController")
            return UINavigationController(rootViewController: controller)
        
        case .trending:
            let controller = UIStoryboard(name: "TrendViewController", bundle: nil)
                .instantiateViewController(withIdentifier: "TrendViewController")
            return UINavigationController(rootViewController: controller)
            
        case .cinema:
            let controller = UIStoryboard(name: "CinemaViewController", bundle: nil)
                .instantiateViewController(withIdentifier: "CinemaViewController")
            return UINavigationController(rootViewController: controller)
            
        case .mypage:
            return UINavigationController(rootViewController: UIViewController())
        }
    }
}

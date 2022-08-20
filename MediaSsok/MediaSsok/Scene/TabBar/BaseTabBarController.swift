//
//  BaseTabBarController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/20.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
        configureTabBarAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureTabBarAppearance()
    }
}

extension BaseTabBarController {
    
    private func configureTabBarAppearance() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

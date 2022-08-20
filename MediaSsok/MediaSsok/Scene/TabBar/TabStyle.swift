//
//  TabStyle.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/20.
//

import UIKit

enum TabStyle: CaseIterable {
    case home
    case trending
    case cinema
    case mypage
}

extension TabStyle {
    var title: String? {
        switch self {
        case .home:
            return "Home"
        case .trending:
            return "Trending"
        case .cinema:
            return "Cinema"
        case .mypage:
            return "MyPage"
        }
    }
    
    var inactiveIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .trending:
            return UIImage(systemName: "play.rectangle")
        case .cinema:
            return UIImage(systemName: "building")
        case .mypage:
            return UIImage(systemName: "person")
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")
        case .trending:
            return UIImage(systemName: "play.rectangle.fill")
        case .cinema:
            return UIImage(systemName: "building.fill")
        case .mypage:
            return UIImage(systemName: "person.fill")
        }
    }
}

extension TabStyle {
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}

//
//  IntroPageViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/21.
//

import UIKit

final class IntroPageViewController: UIPageViewController {
    
    private let contentViewControllers: [UIViewController] = [
        FirstContentViewController(),
        SecondContentViewController(),
        ThirdContentViewController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageViewController()
    }
}

extension IntroPageViewController {
    
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        
        if let first = contentViewControllers.first {
            
            setViewControllers([first], direction: .forward, animated: true)
        }
    }
}

extension IntroPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewControllers.firstIndex(of: viewController) else { return nil }
        let prevIndex = currentIndex - 1
        return prevIndex < 0 ? nil : contentViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = contentViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex >= contentViewControllers.count ? nil : contentViewControllers[nextIndex]
    }
}

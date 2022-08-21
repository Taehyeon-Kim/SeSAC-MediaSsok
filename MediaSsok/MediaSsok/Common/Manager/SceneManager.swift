//
//  SceneManager.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/20.
//

import UIKit

enum Scene {
    static let detail = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    static let video = UIStoryboard(name: "VideoViewController", bundle: nil).instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
}

enum TransitionStyle {
    case present
    case push
}

protocol SceneManagerType: AnyObject {
    func transition<T: UIViewController>(to scene: T, using Style: TransitionStyle, animated: Bool, completion: ((T) -> ())?)
}

final class SceneManager: SceneManagerType {
    
    private var currentViewController: UIViewController
    
    required init(controller currentViewController: UIViewController) {
        self.currentViewController = currentViewController
    }
    
    func transition<ViewController: UIViewController>(to scene: ViewController, using Style: TransitionStyle, animated: Bool, completion: ((ViewController) -> ())? = nil) {
        
        completion?(scene)
        
        switch Style {
        case .present:
            currentViewController.present(scene, animated: true)
            
        case .push:
            guard let nav = currentViewController.navigationController else { return }
            nav.pushViewController(scene, animated: true)
        }
    }
}

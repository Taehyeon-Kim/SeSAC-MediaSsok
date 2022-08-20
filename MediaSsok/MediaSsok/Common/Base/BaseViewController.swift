//
//  BaseViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAttribute()
        configureLayout()
    }
    
    func configureAttribute() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureLayout() {}
}

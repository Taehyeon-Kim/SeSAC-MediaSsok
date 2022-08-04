//
//  DetailViewController.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

final class DetailViewController: UITableViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let dataSource = DetailTableViewDataSource()
    private let delegate = DetailTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}

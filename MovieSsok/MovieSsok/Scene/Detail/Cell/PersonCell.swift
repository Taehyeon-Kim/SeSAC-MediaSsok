//
//  PersonCell.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

final class PersonCell: UITableViewCell {
    
    static let reuseIdentifier = "PersonCell"
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personOriginalNameLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
}

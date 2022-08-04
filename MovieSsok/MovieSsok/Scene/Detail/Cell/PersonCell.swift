//
//  PersonCell.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

import Kingfisher

final class PersonCell: UITableViewCell {
    
    static let reuseIdentifier = "PersonCell"
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personOriginalNameLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personImageView.layer.cornerRadius = 12
        personImageView.contentMode = .scaleAspectFill
    }

    func configure(with data: Person?) {
        let imageURL = URL(string: APIConstants.imageBaseURL + (data?.profilePath ?? ""))
        personImageView.kf.setImage(
            with: imageURL,
            placeholder: nil,
            options: [.transition(.fade(1.2))]
        )
        personOriginalNameLabel.text = data?.originalName
        personNameLabel.text = data?.name
    }
}

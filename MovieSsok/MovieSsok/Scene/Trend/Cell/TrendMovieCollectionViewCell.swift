//
//  TrendMovieCollectionViewCell.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

final class TrendMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TrendMovieCollectionViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        backgroundColor = .clear
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        thumbnailImageView.layer.cornerRadius = 12
    }

    func bind() {
        
    }
}

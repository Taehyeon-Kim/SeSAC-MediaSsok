//
//  TrendMovieCollectionViewCell.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

import Kingfisher

final class TrendMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TrendMovieCollectionViewCell"

    
    // MARK: - UI Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Properties
    
    typealias CompletionHandler = (() -> ())
    var videoCompletionHandler: CompletionHandler?
    
    // MARK: - Override Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    @IBAction func linkButtonTapped(_ sender: UIButton) {
        videoCompletionHandler?()
    }
    
    func style() {
        backgroundColor = .clear
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 3
        
        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        thumbnailImageView.layer.cornerRadius = 12
    }

    func bind(withMedia media: Media) {
        if let url = URL(string: Constants.URL.imageBaseURL + media.posterPath) {
            thumbnailImageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [.transition(.fade(1.2))]
            )
        }
        dateLabel.text = media.releaseDate
        categoryLabel.text = media.title
        rateLabel.text = "\(round(media.rate))"
        titleLabel.text = media.originalTitle
        descriptionLabel.text = media.overview
    }
}

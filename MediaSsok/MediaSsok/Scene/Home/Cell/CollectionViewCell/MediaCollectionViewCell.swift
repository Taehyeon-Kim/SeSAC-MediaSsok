//
//  MediaCollectionViewCell.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

final class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        layer.cornerRadius = 12
    }
}

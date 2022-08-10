//
//  MediaSectionTableViewCell.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

final class MediaSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        configureCollectionView()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
}

//
//  TrendCollectionViewDelegate.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/05.
//

import UIKit

final class TrendCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private let viewController: TrendViewController
    
    init(viewController: TrendViewController) {
        self.viewController = viewController
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController.pushToDetailViewController(indexPath: indexPath)
    }
}

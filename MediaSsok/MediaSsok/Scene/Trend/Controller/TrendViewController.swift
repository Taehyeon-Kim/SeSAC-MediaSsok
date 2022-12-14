//
//  TrendViewController.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftUI

final class TrendViewController: BaseViewController {
    
    private lazy var dataSource = TrendCollectionViewDataSource(collectionView: collectionView, viewController: self)
    private lazy var delegate = TrendCollectionViewDelegate(viewController: self)
    private lazy var sceneManager = SceneManager(controller: self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
}

extension TrendViewController {
    private func configureCollectionView() {
        let nib = UINib(nibName: TrendMovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendMovieCollectionViewCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.prefetchDataSource = dataSource
        collectionView.delegate = delegate
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 460)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }

    func pushToDetailViewController(indexPath: IndexPath) {
        let mediaList = dataSource.getMediaList()

        sceneManager.transition(to: Scene.detail, using: .push, animated: true) {
            $0.media = mediaList[indexPath.row]
        }
    }
    
    func showVideoViewController(movieId: Int) {
        sceneManager.transition(to: Scene.video, using: .present, animated: true) {
            $0.movieId = movieId
        }
    }
}

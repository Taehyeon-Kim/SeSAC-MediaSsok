//
//  TrendViewController.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

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
        let detailViewController = Scene.detail
        let mediaList = dataSource.getMediaList()
        detailViewController.media = mediaList[indexPath.row]
        sceneManager.transition(to: detailViewController, using: .push, animated: true)
    }
    
    func showVideoViewController(movieId: Int) {
        let videoViewController = Scene.video
        videoViewController.movieId = movieId
        present(videoViewController, animated: true)
    }
}

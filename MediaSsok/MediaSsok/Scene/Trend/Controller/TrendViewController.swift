//
//  TrendViewController.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

final class TrendViewController: UIViewController {
    
    private var mediaList: [Media] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchTrendMediaList()
    }
}

extension TrendViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    private func configureCollectionView() {
        let nib = UINib(nibName: TrendMovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendMovieCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 460)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(withMedia: mediaList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.media = mediaList[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension TrendViewController {

    private func fetchTrendMediaList(
        for mediaType: String = "movie",
        at timeWindow: String = "week",
        page: Int = 3
    ) {
        TrendingService.shared.fetchTrendMediaList(for: mediaType, at: timeWindow, page: page) { mediaList in
            DispatchQueue.main.async { [weak self] in
                self?.mediaList.append(contentsOf: mediaList)
                self?.collectionView.reloadData()
            }
        }
    }
}

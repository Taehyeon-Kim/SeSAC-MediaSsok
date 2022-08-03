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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchTrendMovieList(for: "movie", at: "week")
    }
}

extension TrendViewController: UICollectionViewDataSource {
    private func configureCollectionView() {
        let nib = UINib(nibName: TrendMovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendMovieCollectionViewCell.identifier)
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 460)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TrendViewController {
    func fetchTrendMovieList(for mediaType: String, at timeWindow: String) {
        let url = APIConstants.getTrendingURL + "/\(mediaType)/\(timeWindow)" + "?api_key=\(Keys.TMDB)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

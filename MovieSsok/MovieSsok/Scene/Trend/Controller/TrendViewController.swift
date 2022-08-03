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
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(withMedia: mediaList[indexPath.row])
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
                let movies = json["results"].arrayValue
                for movie in movies {
                    let media = Media(
                        releaseData: movie["release_date"].stringValue,
                        title: movie["title"].stringValue,
                        posterPath: movie["backdrop_path"].stringValue,
                        rate: movie["vote_average"].doubleValue,
                        originalTitle: movie["original_title"].stringValue,
                        overview: movie["overview"].stringValue
                    )
                    self.mediaList.append(media)
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

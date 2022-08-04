//
//  DetailViewController.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

final class DetailViewController: UITableViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let dataSource = DetailTableViewDataSource()
    private let delegate = DetailTableViewDelegate()
    
    var media: Media?
    var casts: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        displayData()
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData(for: media?.id ?? 0)
        tableView.reloadData()
    }
}

extension DetailViewController {
    
    private func configureUI() {
        backgroundImageView.contentMode = .scaleAspectFill
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    
    private func displayData() {
        let imageURL = URL(string: APIConstants.imageBaseURL + (media?.posterPath ?? ""))
        backgroundImageView.kf.setImage(with: imageURL)
        titleLabel.text = media?.title
        descriptionLabel.text = media?.releaseDate
    }
    
    func fetchData(for movieId: Int) {
        let url = APIConstants.movieBaseURL + "/\(movieId)/credits" + "?api_key=\(Keys.TMDB)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for cast in json["cast"].arrayValue {
                    let cast = Person(name: cast["name"].stringValue, originalName: cast["original_name"].stringValue, profilePath: cast["profile_path"].stringValue)
                    self.casts.append(cast)
                }
                
                self.dataSource.updateData(self.casts)
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

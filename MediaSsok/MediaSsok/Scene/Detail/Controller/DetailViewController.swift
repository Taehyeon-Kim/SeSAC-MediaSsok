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
    }
}

extension DetailViewController {
    
    private func configureUI() {
        backgroundImageView.contentMode = .scaleAspectFill
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    
    private func displayData() {
        let imageURL = URL(string: Constants.URL.imageBaseURL + (media?.posterPath ?? ""))
        backgroundImageView.kf.setImage(with: imageURL)
        titleLabel.text = media?.title
        descriptionLabel.text = media?.releaseDate
    }
    
    // 네트워크 통신 호출 코드는 DataSource 쪽에 있는 것보다 Controller에 있는게 더 자연스러운 것 같다.
    // DataSource 쪽에는 데이터만 넘겨준다.
    // 위의 생각이 자연스러운 것 같은데 그렇다면 prefetching 처리를 어떻게 해주어야 할지 감이 잘 오지 않는다.
    private func fetchData(for movieId: Int) {
        MovieService.shared.fetchCasts(for: movieId) { casts in
            self.dataSource.updateData(casts)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

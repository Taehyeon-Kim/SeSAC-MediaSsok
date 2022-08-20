//
//  HomeViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

import Kingfisher

final class HomeViewController: UIViewController {
    
    private var sectionTitle: [String] = []
    private var media: [[Content]] = []
    
    private lazy var tableHeaderView = MainBannerView(
        frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3 * 2)
    )
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchHomeMedia()
    }
}

// MARK: - Helpers
extension HomeViewController {
    
    private func configureUI() {
        view.backgroundColor = .clear
        navigationController?.navigationBar.isHidden = true
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MediaSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaSectionTableViewCell")
        tableView.tableHeaderView = tableHeaderView
        tableView.backgroundColor = .black
    }
    
    private func fetchHomeMedia() {
        MovieService.shared.fetchHomeMedia { pages, value in
            self.sectionTitle.append(contentsOf: pages)
            self.media.append(contentsOf: value)
            DispatchQueue.main.async {
                let url = URL(string: Constants.URL.imageBaseURL + (value.first?.first?.posterPath ?? ""))
                self.tableHeaderView.posterImageView.kf.setImage(with: url)
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaSectionTableViewCell", for: indexPath) as? MediaSectionTableViewCell else {
            return UITableViewCell()
        }
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.section
        cell.collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCollectionViewCell")
        cell.titleLabel.text = sectionTitle[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}


// MARK: - CollectionView DataDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = URL(string: Constants.URL.imageBaseURL + media[collectionView.tag][indexPath.item].posterPath)
        cell.thumbnailImageView.kf.setImage(with: url)
        return cell
    }
}


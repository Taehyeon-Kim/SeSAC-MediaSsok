//
//  TrendCollectionViewDataSource.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/05.
//

import UIKit

final class TrendCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    private var mediaList: [Media] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var startPage = 1
    private var totalPages = 0
    private var collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        fetchTrendMediaList()
    }
    
    func getMediaList() -> [Media] {
        return mediaList
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.bind(withMedia: mediaList[indexPath.row])
        return cell
    }

    
    // MARK: - UICollectionViewDataSourcePrefetching
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if mediaList.indices.last == indexPath.item && mediaList.count < totalPages {
                startPage += 1
                fetchTrendMediaList(page: startPage)
            }
        }
    }
    
    
    // MARK: - Private Functions
    // - 과연 DataSource 쪽에서 서버 통신을 하는 것이 맞을까?
    
    private func fetchTrendMediaList(
        for mediaType: String = "movie",
        at timeWindow: String = "week",
        page: Int = 1
    ) {
        TrendingService.shared.fetchTrendMediaList(for: mediaType, at: timeWindow, page: page) { mediaList, totalPages in
            DispatchQueue.main.async { [weak self] in
                self?.totalPages = totalPages
                self?.mediaList.append(contentsOf: mediaList)
            }
        }
    }
}

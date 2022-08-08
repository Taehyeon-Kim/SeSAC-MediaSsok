//
//  VideoViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/08.
//

import UIKit

final class VideoViewController: UIViewController {
    
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieService.shared.fetchVideos(for: movieId ?? 0) { json in
            print(json)
        }
    }
}

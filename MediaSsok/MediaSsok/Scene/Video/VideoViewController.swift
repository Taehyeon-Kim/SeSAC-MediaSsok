//
//  VideoViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/08.
//

import UIKit
import WebKit

final class VideoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieId = movieId else { return }
        self.fetchVideos(for: movieId)
    }
}

extension VideoViewController {
    
    private func fetchVideos(for movieId: Int) {
        MovieService.shared.fetchVideos(for: movieId) { json in
            let keyArray = json["results"].arrayValue.map { $0["key"].stringValue }
            guard let key = keyArray.first else { return }
            let urlString = "https://www.youtube.com/watch?v=\(key)"
            self.openWebPage(urlString: urlString)
        }
    }
    
    private func openWebPage(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            DispatchQueue.main.async { [weak self] in
                self?.webView.load(request)
            }
        }
    }
}

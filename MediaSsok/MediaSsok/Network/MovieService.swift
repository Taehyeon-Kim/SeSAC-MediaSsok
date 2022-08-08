//
//  MovieService.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/05.
//

import Alamofire
import SwiftyJSON

final class MovieService {
    
    static let shared = MovieService()
    
    private init() {}
    
    typealias completion = ([Person]) -> ()
    
    func fetchCasts(
        for movieId: Int,
        completion: @escaping completion
    )
    {
        let trendingBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/\(movieId)/credits"
        let query = "?api_key=\(Keys.TMDB)"
        let url = trendingBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let casts = json["cast"].arrayValue.map {
                    Person(
                        name:           $0["name"].stringValue,
                        originalName:   $0["original_name"].stringValue,
                        profilePath:    $0["profile_path"].stringValue
                    )
                }
                
                completion(casts)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchVideos(
        for movieId: Int,
        completion: @escaping (JSON) -> ()?
    )
    {
        let trendingBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/\(movieId)/videos"
        let query = "?api_key=\(Keys.TMDB)"
        let url = trendingBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                completion(json)

            case .failure(let error):
                print(error)
            }
        }
    }
}


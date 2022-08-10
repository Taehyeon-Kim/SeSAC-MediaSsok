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
    
    let homeMedia = [
        "최신 영화",
        "인기 영화",
        "개봉 예정인 영화"
    ]
    
    func fetchCasts(
        for movieId: Int,
        completion: @escaping completion
    )
    {
        let movieBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/\(movieId)/credits"
        let query = "?api_key=\(Keys.TMDB)"
        let url = movieBaseURL + pathParameter + query
        
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
        completion: @escaping (JSON) -> ()
    )
    {
        let movieBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/\(movieId)/videos"
        let query = "?api_key=\(Keys.TMDB)"
        let url = movieBaseURL + pathParameter + query
        
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
    
    func fetchPopulars(page: Int = 1, completion: @escaping (Int, [Content]) -> ())
    {
        let movieBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/popular"
        let query = "?api_key=\(Keys.TMDB)&page=\(page)"
        let url = movieBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = json["results"].arrayValue
                let populars = results.map {
                    Popular(
                        id: $0["id"].intValue,
                        title: $0["title"].stringValue,
                        overview: $0["overview"].stringValue,
                        posterPath: $0["poster_path"].stringValue
                    )
                }
                
                completion(json["total_pages"].intValue, populars)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopRated(page: Int = 1, completion: @escaping (Int, [Content]) -> ())
    {
        let movieBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/top_rated"
        let query = "?api_key=\(Keys.TMDB)&page=\(page)"
        let url = movieBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = json["results"].arrayValue
                let topRated = results.map {
                    TopRated(
                        id: $0["id"].intValue,
                        title: $0["title"].stringValue,
                        overview: $0["overview"].stringValue,
                        posterPath: $0["poster_path"].stringValue
                    )
                }
                
                completion(json["total_pages"].intValue, topRated)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUpcoming(page: Int = 1, completion: @escaping (Int, [Content]) -> ())
    {
        let movieBaseURL = Constants.URL.movieBaseURL
        let pathParameter = "/upcoming"
        let query = "?api_key=\(Keys.TMDB)&page=\(page)"
        let url = movieBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = json["results"].arrayValue
                let topRated = results.map {
                    Upcoming(
                        id: $0["id"].intValue,
                        title: $0["title"].stringValue,
                        overview: $0["overview"].stringValue,
                        posterPath: $0["poster_path"].stringValue
                    )
                }
                
                completion(json["total_pages"].intValue, topRated)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchHomeMedia(completion: @escaping ([String], [[Content]]) -> ()) {
        var contents: [[Content]] = []
        
        self.fetchPopulars { pages, value in
            contents.append(value)
            
            self.fetchTopRated { pages, value in
                contents.append(value)
                
                self.fetchUpcoming { pages, value in
                    contents.append(value)
                    
                    completion(self.homeMedia, contents)
                }
            }
        }
    }
}


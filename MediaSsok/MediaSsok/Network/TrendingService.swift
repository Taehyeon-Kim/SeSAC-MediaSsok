//
//  TrendingService.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/05.
//

import Alamofire
import SwiftyJSON

final class TrendingService {
    
    static let shared = TrendingService()
    
    private init() {}
    
    typealias completion = ([Media], Int) -> ()
    
    func fetchTrendMediaList(
        for mediaType: String,
        at timeWindow: String,
        page: Int,
        completion: @escaping completion
    )
    {
        let trendingBaseURL = Constants.URL.trendingBaseURL
        let pathParameter = "/\(mediaType)/\(timeWindow)"
        let query = "?api_key=\(Keys.TMDB)&page=\(page)"
        let url = trendingBaseURL + pathParameter + query
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let mediaList = json["results"].arrayValue.map {
                    Media(
                        id:             $0["id"].intValue,
                        releaseDate:    $0["release_date"].stringValue,
                        title:          $0["title"].stringValue,
                        posterPath:     $0["backdrop_path"].stringValue,
                        rate:           $0["vote_average"].doubleValue,
                        originalTitle:  $0["original_title"].stringValue,
                        overview:       $0["overview"].stringValue
                    )
                }
                let totalPages = json["total_pages"].intValue
                
                completion(mediaList, totalPages)

            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  Constants.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    static let getTrendingURL = baseURL + "/trending"
    static let movieBaseURL = baseURL + "/movie"
}

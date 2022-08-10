//
//  Media.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/04.
//

import Foundation

protocol Content {
    var id: Int { get }
    var title: String { get }
    var overview: String { get }
    var posterPath: String { get }
}

struct Media: Content {
    var id: Int
    let releaseDate: String
    var title: String
    var posterPath: String
    let rate: Double
    let originalTitle: String
    var overview: String
}

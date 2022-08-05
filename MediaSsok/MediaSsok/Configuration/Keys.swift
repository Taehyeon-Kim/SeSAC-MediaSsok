//
//  Keys.swift
//  MovieSsok
//
//  Created by taekki on 2022/08/03.
//

import Foundation

enum Keys {
    static var TMDB: String {
        guard
            let APIKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        else {
            fatalError("API KEY 접근이 잘못되었습니다.")
        }
        return APIKey
    }
}

//
//  DateFormatType.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import Foundation

enum DateFormatType {
    case full
    case year
    case utc
    case utcWithSlash
    
    var description: String {
        switch self {
        case .full:
            return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        case .year:
            return "yyyy-MM-dd"
        case .utc:
            return "MM-dd-yyyy"
        case .utcWithSlash:
            return "MM/dd/yyyy"
        }
    }
}

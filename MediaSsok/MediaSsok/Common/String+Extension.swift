//
//  String+Extension.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

extension String {
    
    func toDate(to type: DateFormatType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.date(from: self)
    }
}

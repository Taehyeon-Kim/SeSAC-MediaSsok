//
//  Date+Extension.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

extension Date {
    
    func toString(of type: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.string(from: self)
    }
}

//
//  Logger.swift
//  MediaSsok-Core
//
//  Created by taekki on 2022/08/21.
//

import Foundation

func print(_ object: Any) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print(object)
    #endif
}

public enum Logger {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public static func log<T>(
        _ object: @autoclosure () -> T,
        _ option: Option = .info,
        _ describe: String = .empty,
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line
    ) {
        let object: T = object()
        let fileURL: String = NSURL(string: file)?.lastPathComponent ?? .empty
        let thread = Thread.isMainThread ? "[🎨 Main Thread]" : "[⚙️ BG Thread]"
        let timestamp = self.dateFormatter.string(from: Date())
        
        print(timestamp, option.rawValue, thread, "[\(fileURL)]:\(line)", "\(function)", "=>\(describe)", String(reflecting: object), separator: " ")
    }
    
}

extension Logger {
    
    public enum Option: String {
        case info = "[ℹ️]" // info
        case error = "[‼️]" // error
        case debug = "[💬]" // debug
        case warning = "[⚠️]" // warning
        case severe = "[🔥]" // severe
    }
}

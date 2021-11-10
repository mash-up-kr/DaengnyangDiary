//
//  DateExtension.swift
//  DaengnyangDiary
//
//  Created by Yoojin Park on 2021/10/03.
//

import Foundation

extension Date {
    func toString(format: DateFormatType, timeZone: TimeZoneEnum = .utc) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone.timeZone
        dateFormatter.dateFormat = format.format
        
        return dateFormatter.string(from: self)
    }
    
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
         return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
         return Calendar.current.component(.day, from: self)
    }
}

enum TimeZoneEnum {
    case current
    case utc
    
    var timeZone: TimeZone {
        switch self {
        case .current:
            return TimeZone.current
        case .utc:
            return TimeZone(identifier: "UTC") ?? TimeZone.current
        }
    }
}

enum DateFormatType {
    case year
    
    var format: String {
        switch self {
        case .year:
            return "yyyy"
        }
    }
}

//
//  String + Utilities.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

extension String {
    static func isNilOrEmpty(_ string: String?) -> Bool {
        if string == nil { return true }
        if string!.count <= 0 { return true }
        
        return false
    }
    
    static func selfOrNA(_ string: String?) -> String {
        return String.isNilOrEmpty(string) ? "N/A" : string!
    }
    
    func asDateFromDateTimeStamp() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: self)
        }
        
    }
    
    func asDateFromDateStamp() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func asDateFromDateStampNoDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        return dateFormatter.date(from: self)
    }
}

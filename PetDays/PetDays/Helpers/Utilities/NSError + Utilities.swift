//
//  NSError + Utilities.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

extension NSError {
    static func standardErrorWithString(errorString: String) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: [NSLocalizedDescriptionKey : errorString])
    }
    
    static func standardNoDataError() -> Error {
        return NSError.standardErrorWithString(errorString: "No data was returned for this request.")
    }
}

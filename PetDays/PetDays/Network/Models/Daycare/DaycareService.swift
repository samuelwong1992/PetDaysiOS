//
//  DaycareService.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation

extension Daycare {
    static func search(desc: String, completion: @escaping((_ daycares: [Daycare], _ error: Error?) -> Void)) {
        let request = DaycareAPI.search(desc: desc)
        APIManager.current.performRequest(request: request) { (model: [Daycare]?, error) in
            guard error == nil else { return completion([], error) }
            guard let daycares = model else { return completion([], NSError.standardNoDataError()) }
            
            return completion(daycares, nil)
        }
    }
}

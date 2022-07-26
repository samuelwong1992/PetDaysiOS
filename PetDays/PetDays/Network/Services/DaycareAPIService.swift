//
//  DaycareAPIService.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import Foundation

class DaycareAPIService: DaycareService {
    func search(desc: String, completion: @escaping((_ daycares: [Daycare], _ error: Error?) -> Void)) {
        let request = DaycareAPI.search(desc: desc)
        APIManager.current.performRequest(request: request, shouldShowLoading: false) { (model: [Daycare]?, error) in
            guard error == nil else { return completion([], error) }
            guard let daycares = model else { return completion([], NSError.standardNoDataError()) }
            
            return completion(daycares, nil)
        }
    }
}

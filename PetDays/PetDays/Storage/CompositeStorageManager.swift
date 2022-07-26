//
//  CompositeStorageManager.swift
//  PetDays
//
//  Created by Samuel Wong on 26/7/2022.
//

import Foundation

fileprivate var _current = CompositeStorageManager()

class CompositeStorageManager: StorageManager {
    static var current: CompositeStorageManager {
        return _current
    }
    
    var apiManager: APIManager = APIManager.current
    
    func performRequest<T>(request: APIRequest, shouldShowLoading: Bool, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        return apiManager.performRequest(request: request, shouldShowLoading: shouldShowLoading, completion: completion)
    }
}

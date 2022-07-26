//
//  DontMatterStorageManager.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 26/7/2022.
//

import Foundation
@testable import PetDays

class DontMatterStorageManager: StorageManager {
    func performRequest<T>(request: APIRequest, shouldShowLoading: Bool, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        return completion(nil, nil)
    }
}

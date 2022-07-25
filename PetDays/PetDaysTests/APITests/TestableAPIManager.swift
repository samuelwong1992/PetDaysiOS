//
//  TestableAPIManager.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 25/7/2022.
//

import Foundation
@testable import PetDays

extension APIManager {
    static func testable(withExistingToken: Bool) -> APIManager {
        let path = "http://127.0.0.1:8000/"
        
        return APIManager(baseURL: path, persistanceManager: TestPersistanceManager(withExistingToken: withExistingToken))
    }
}

private var _apiManager: APIManager!

class TestableAPIManager {
    static func resetManager() {
        _apiManager = nil
    }
    
    static func current(withExistingToken: Bool? = nil) -> APIManager {
        var toReturn: APIManager?
        if let _apiManager = _apiManager {
            toReturn = _apiManager
        } else {
            toReturn = APIManager.testable(withExistingToken: withExistingToken ?? true)
        }
        
        return toReturn!
    }
}

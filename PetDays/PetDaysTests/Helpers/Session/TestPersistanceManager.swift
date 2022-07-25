//
//  TestPersistanceManager.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 25/7/2022.
//

import Foundation
@testable import PetDays

class TestPersistanceManager: PersistanceManager {
    var withExistingToken: Bool
    
    internal init(withExistingToken: Bool) {
        self.withExistingToken = withExistingToken
    }
    
    
    func getAPIToken() -> String? {
        return self.withExistingToken ? "bc637faa6df2022e4d3ff2b7a0bd27f9f8f90863" : nil
    }
    
    func saveAPIToken(token: String) {
        self.withExistingToken = true
    }
    
    func clearAPIToken() {
        self.withExistingToken = false
    }
}

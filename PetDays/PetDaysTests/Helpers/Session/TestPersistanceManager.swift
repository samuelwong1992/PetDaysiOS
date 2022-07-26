//
//  TestPersistanceManager.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 25/7/2022.
//

import Foundation
@testable import PetDays

class TestPersistanceManager: PersistanceManager {
    private var token: String?
    
    internal init(withExistingToken: Bool) {
        self.token = withExistingToken ? "bc637faa6df2022e4d3ff2b7a0bd27f9f8f90863" : nil
    }
    
    
    func getAPIToken() -> String? {
        return self.token
    }
    
    func saveAPIToken(token: String) {
        self.token = token
    }
    
    func clearAPIToken() {
        self.token = nil
    }
}

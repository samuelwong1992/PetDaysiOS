//
//  UserTestService.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 25/7/2022.
//

import Foundation
@testable import PetDays

class UserTestService: UserService {
    var persistanceManager: PersistanceManager
    var succeeds: Bool
    
    internal init(persistanceManager: PersistanceManager, succeeds: Bool) {
        self.persistanceManager = persistanceManager
        self.succeeds = succeeds
    }
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        if succeeds {
            persistanceManager.saveAPIToken(token: "Some Token")
            return completion(nil)
        } else {
            return completion(NSError.standardErrorWithString(errorString: "Some Error"))
        }
    }
    
    func register(username: String, password: String, password2: String, firstName: String, lastName: String, completion: @escaping (Error?) -> Void) {
        if succeeds {
            persistanceManager.saveAPIToken(token: "Some Token")
            return completion(nil)
        } else {
            return completion(NSError.standardErrorWithString(errorString: "Some Error"))
        }
    }
}

//
//  User.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

fileprivate var _currentUser: User?

class User {
    static var currentUser: User? {
        get {
            return _currentUser
        }
        set {
            _currentUser = newValue
        }
    }
    
    var apiToken: String
    
    init(apiToken: String) {
        self.apiToken = apiToken
    }
}

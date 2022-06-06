//
//  User.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

fileprivate var _currentUser: User?

class User: APIObject {
    static var currentUser: User? {
        get {
            return _currentUser
        }
    }
    
    var _apiToken: String?
}

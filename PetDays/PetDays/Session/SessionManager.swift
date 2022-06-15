//
//  SessionManager.swift
//  PetDays
//
//  Created by Samuel Wong on 15/6/2022.
//

import Foundation

fileprivate var _currentUser: User?
fileprivate var _currentProfile: Profile?

class SessionManager {}

extension SessionManager {
    static var currentProfile: Profile? {
        get {
            return _currentProfile
        }
        set {
            _currentProfile = newValue
        }
    }
}

extension SessionManager {
    static var currentUser: User? {
        get {
            return _currentUser
        }
        set {
            _currentUser = newValue
        }
    }
}

//
//  UserService.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

extension User {
    static func login(username: String, password: String, completion: @escaping(_ error: Error?) -> Void) {
        let request = LoginAPI.login(username: username, password: password)
        APIManager.current.performRequest(request: request) { (response: LoginResponse?, error) in
            guard error == nil else { return completion(error) }
            guard let response = response else { return completion(NSError.standardNoDataError()) }
            
            User.currentUser = User(apiToken: response.token)
            Profile.currentProfile = response.profile
            
            return completion(nil)
        }
    }
}

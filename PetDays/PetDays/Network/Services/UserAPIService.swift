//
//  UserAPIService.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import Foundation

class UserAPIService: UserService {
    var persistanceManager: PersistanceManager
    
    internal init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
    
    func login(username: String, password: String, completion: @escaping(_ error: Error?) -> Void) {
        let request = LoginAPI.login(username: username, password: password)
        APIManager.current.performRequest(request: request) { (response: LoginResponse?, error) in
            guard error == nil else { return completion(error) }
            guard let response = response else { return completion(NSError.standardNoDataError()) }
            
            self.persistanceManager.saveAPIToken(token: response.token)
            
            SessionManager.current.user = User(apiToken: response.token)
            SessionManager.current.profile = response.profile
            
            return completion(nil)
        }
    }
    
    func register(username: String, password: String, password2: String, firstName: String, lastName: String, completion: @escaping(_ error: Error?) -> Void) {
        let request = LoginAPI.register(username: username, password: password, password2: password2, firstName: firstName, lastName: lastName)
        APIManager.current.performRequest(request: request) { (response: LoginResponse?, error) in
            guard error == nil else { return completion(error) }
            guard let response = response else { return completion(NSError.standardNoDataError()) }
            
            self.persistanceManager.saveAPIToken(token: response.token)
            
            SessionManager.current.user = User(apiToken: response.token)
            SessionManager.current.profile = response.profile
            
            return completion(nil)
        }
    }
}
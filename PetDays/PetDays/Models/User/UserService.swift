//
//  UserService.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

protocol UserService {
    var persistanceManager: PersistanceManager { get set }
    
    func login(username: String, password: String, completion: @escaping(_ error: Error?) -> Void)
    func register(username: String, password: String, password2: String, firstName: String, lastName: String, completion: @escaping(_ error: Error?) -> Void)
}

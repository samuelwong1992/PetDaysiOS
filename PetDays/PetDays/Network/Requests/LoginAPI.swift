//
//  LoginAPI.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation
import Alamofire

enum LoginAPI: APIRequest {
    case login(username: String, password: String)
    
    var endpoint: String {
        switch self {
        case .login(_, _) :
            return "rest-api/login/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _) :
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password) :
            return [
                "username" : username,
                "password" : password
            ]
        }
    }
}

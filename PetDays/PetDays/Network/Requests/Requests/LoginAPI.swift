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
    case register(username: String, password: String, password2: String, firstName: String, lastName: String)
    
    var endpoint: String {
        switch self {
        case .login(_, _) :
            return APIConstants.Endpoint.Login.endpoint
        case .register(_, _, _, _, _) :
            return APIConstants.Endpoint.Register.endpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login(_, _) :
            return .post
        case .register(_, _, _, _, _) :
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password) :
            return [
                APIConstants.APIKeys.User.username.key : username,
                APIConstants.APIKeys.User.password.key : password
            ]
        case .register(let username, let password, let password2, let firstName, let lastName) :
            return [
                APIConstants.APIKeys.User.username.key : username,
                APIConstants.APIKeys.User.password.key : password,
                APIConstants.APIKeys.User.password2.key : password2,
                APIConstants.APIKeys.User.firstName.key : firstName,
                APIConstants.APIKeys.User.lastName.key : lastName
            ]
        }
    }
}

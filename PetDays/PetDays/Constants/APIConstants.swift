//
//  APIConstants.swift
//  PetDays
//
//  Created by Samuel Wong on 8/6/2022.
//

import Foundation

struct APIConstants {
    enum Endpoint {
        case Login
        case Register
        
        var endpoint: String {
            switch self {
            case .Login : return "rest-api/login/"
            case .Register : return "rest-api/register/"
            }
        }
    }
    
    struct APIKeys {
        enum User {
            case username
            case password
            case password2
            case firstName
            case lastName
            
            var key: String {
                switch self {
                case .username : return "username"
                case .password : return "password"
                case .password2 : return "password2"
                case .firstName : return "first_name"
                case .lastName : return "last_name"
                }
            }
        }
    }
}

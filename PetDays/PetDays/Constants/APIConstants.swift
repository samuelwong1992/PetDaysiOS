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
        
        case Pet
        case RequestDaycare(petId: Int)
        
        var endpoint: String {
            switch self {
            case .Login : return "rest-api/login/"
            case .Register : return "rest-api/register/"
                
            case .Pet : return "rest-api/pet/"
            case .RequestDaycare(let petId) : return Endpoint.Pet.endpoint + "\(petId)/request-daycare/"
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
        
        enum Pet {
            case name
            case profilePicture
            
            var key: String {
                switch self {
                case .name : return "name"
                case .profilePicture : return "profile_picture"
                }
            }
        }
        
        enum Misc {
            case Daycare
            
            var key: String {
                switch self {
                case .Daycare : return "daycare"
                }
            }
        }
    }
}

//
//  APIResponses.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

struct APIResponse {
    static let API_JSON_DEFINED_ERROR = "error"
    
    enum StatusCode: Int {
        //Success 2xx
        case _200_SUCCESS = 200
        case _201_CREATED = 201
        case _202_ACCEPTED = 202
        case _204_NO_CONTENT = 204
        
        //Redirection 3xx
        case _301_MOVED = 301
        case _302_FOUND = 302
        case _303_METHOD = 303
        case _304_NOT_MODIFIED = 304
        
        //Error 4xx
        case _400_BAD_REQUEST = 400
        case _401_UNAUTHORIZED = 401
        case _403_FORBIDDEN = 403
        case _404_NOT_FOUND = 404
        
        //Error 5xx
        case _500_INTERNAL_ERROR = 500
        case _502_SERVER_OVERLOADED = 502
        case _503_GATEWAY_TIMEOUT = 503
        
        case unknown
        
        var code:Int {
            return self.rawValue
        }
        
        var title:String {
            //TODO: Titles For Errors
            switch self {
            case ._200_SUCCESS, ._201_CREATED, ._202_ACCEPTED :
                return "Success"
                
            case ._400_BAD_REQUEST :
                return "Invalid Request"
            case ._401_UNAUTHORIZED :
                return "Authorization Failed"
            case ._403_FORBIDDEN :
                return "Request Failed"
            case ._404_NOT_FOUND :
                return "404 Error"
                
            case ._500_INTERNAL_ERROR :
                return "Internal Server Error"
                
            default :
                return "Server Error"
            }
        }
        
        var description:String {
            //TODO: Descriptions For Errors
            switch self {
            //2xx
            case ._200_SUCCESS, ._201_CREATED, ._202_ACCEPTED :
                return "The response was successful! [Code \(self.code)]\n"
            //3xx
            case ._301_MOVED, ._302_FOUND, ._303_METHOD, ._304_NOT_MODIFIED :
                return "The server responded with a redirection error. [Code \(self.code)]\n"
                
            //4xx
            case ._400_BAD_REQUEST :
                return "The server is unable to perform this request. [Code \(self.code)]\n"
            case ._401_UNAUTHORIZED :
                return "You are not authorized to make this request. [Code \(self.code)]\n"
            case ._403_FORBIDDEN :
                return "The server is refusing to respond to this request. [Code \(self.code)]\n"
            case ._404_NOT_FOUND :
                return "The server was unable to find the resource for this request. [Code \(self.code)]\n"
                
            //5xx
            case ._500_INTERNAL_ERROR :
                return "An unexpected condition was encountered. [Code \(self.code)]\n"
            case ._502_SERVER_OVERLOADED :
                return "The server is currently overloaded. [Code \(self.code)]\n"
            case ._503_GATEWAY_TIMEOUT :
                return "The gateway has timed out. [Code \(self.code)]\n"
                
            default :
                return "The server responded with an unknown error. [Code \(self.code)]\n"
            }
        }
    }
}

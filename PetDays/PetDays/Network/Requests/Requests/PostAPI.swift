//
//  PostAPI.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import Alamofire

enum PostAPI: APIRequest {
    case getFeed(daycare: Daycare?, pet: Pet?)
    
    var endpoint: String {
        switch self {
        case .getFeed(_, _) :
            return APIConstants.Endpoint.Post.endpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeed(_, _) :
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getFeed(_, _) :
            return nil
        }
    }
}

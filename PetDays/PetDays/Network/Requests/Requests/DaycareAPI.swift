//
//  DaycareAPI.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Alamofire

enum DaycareAPI: APIRequest {
    case search(desc: String)
    
    var endpoint: String {
        switch self {
        case .search(_) :
            return APIConstants.Endpoint.Daycare.endpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search(_) :
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let desc) :
            return [APIConstants.APIKeys.Daycare.description.key : desc]
        }
    }
}

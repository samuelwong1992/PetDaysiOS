//
//  PetAPI.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation
import Alamofire

enum PetAPI: APIRequest {
    case create(name: String, image: UIImage?)
    case requestDaycare(petId: Int, daycareId: Int)
    
    var endpoint: String {
        switch self {
        case .create(_, _) :
            return APIConstants.Endpoint.Pet.endpoint
        case .requestDaycare(let petId, _) :
            return APIConstants.Endpoint.RequestDaycare(petId: petId).endpoint
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create(_, _) :
            return .post
        case .requestDaycare(_, _) :
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .create(let name, let image) :
            var toReturn: [String:Any] = [
                APIConstants.APIKeys.Pet.name.key : name
            ]
            if let image = image {
                toReturn[APIConstants.APIKeys.Pet.profilePicture.key] = image
            }
            return toReturn
            
        case .requestDaycare(_, let daycareId) :
            return [APIConstants.APIKeys.Misc.Daycare.key : daycareId]
        }
    }
}


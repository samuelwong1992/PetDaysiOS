//
//  Profile.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

class Profile: APIObject {
    var firstName: String
    var lastName: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
      }
}
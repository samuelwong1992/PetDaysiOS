//
//  Profile.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

protocol Profile {
    var firstName: String { get set }
    var lastName: String { get set }
    var pets: [Pet] { get set }
    var daycares: [Daycare] { get set }
}

class ProfileDecodable: PDDecodableObject, Profile {
    var firstName: String
    var lastName: String
    var pets: [Pet]
    var daycares: [Daycare]
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        pets = try values.decode([PetDecodable].self, forKey: .pets)
        daycares = try values.decode([DaycareDecodable].self, forKey: .daycares)
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case pets
        case daycares
      }
}

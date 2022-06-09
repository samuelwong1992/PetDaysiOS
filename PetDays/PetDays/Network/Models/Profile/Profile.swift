//
//  Profile.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

fileprivate var _currentProfile: Profile?

class Profile: APIObject {
    static var currentProfile: Profile? {
        get {
            return _currentProfile
        }
        set {
            _currentProfile = newValue
        }
    }
    
    var firstName: String
    var lastName: String
    var pets: [Pet]
    var daycares: [Daycare]
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        pets = try values.decode([Pet].self, forKey: .pets)
        daycares = try values.decode([Daycare].self, forKey: .daycares)
        
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

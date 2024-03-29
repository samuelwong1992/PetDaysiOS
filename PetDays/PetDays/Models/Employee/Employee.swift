//
//  Employee.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import Foundation

protocol Employee: PDObject {
    var firstName: String { get set }
    var lastName: String { get set }
    var daycare: Daycare { get set }
    var profilePictureUrl: String? { get set }
    
    
}

extension Employee {
    var fullName: String {
        return self.firstName + " " + self.lastName
    }
}

class EmployeeDecodable: PDDecodableObject, Employee {
    var firstName: String
    var lastName: String
    var daycare: Daycare
    var profilePictureUrl: String?
    
    var fullName: String {
        return self.firstName + " " + self.lastName
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        daycare = try values.decode(DaycareDecodable.self, forKey: .daycare)
        profilePictureUrl = try values.decode(String?.self, forKey: .profilePictureUrl)

        
        try super.init(from: decoder)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case daycare = "daycare"
        case profilePictureUrl = "profile_picture"
    }
}


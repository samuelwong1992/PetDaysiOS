//
//  Pet.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation

protocol Pet: PDObject {
    var name: String { get set }
    var profilePictureUrl: String? { get set }
    var daycares: [Daycare] { get set }
}

class PetDecodable: PDDecodableObject, Pet {
    var name: String
    var profilePictureUrl: String?
    var daycares: [Daycare]
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            name = try values.decode(String.self, forKey: .name)
        } catch {
            name = ""
        }
        do {
            daycares = try values.decode([DaycareDecodable].self, forKey: .daycares)
        } catch {
            daycares = []
        }
        
        profilePictureUrl = try values.decode(String?.self, forKey: .profilePictureUrl)
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePictureUrl = "profile_picture"
        case daycares
    }
}

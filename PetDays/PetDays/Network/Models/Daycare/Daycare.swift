//
//  Daycare.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation

class Daycare: APIObject {
    var name: String
    var address: String
    var profilePictureUrl: String?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        do {
            profilePictureUrl = try values.decode(String?.self, forKey: .profilePictureUrl)
        } catch {
            profilePictureUrl = nil
        }
        
        do {
            address = try values.decode(String.self, forKey: .address)
        } catch {
            address = ""
        }
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case profilePictureUrl = "profile_picture"
      }
}

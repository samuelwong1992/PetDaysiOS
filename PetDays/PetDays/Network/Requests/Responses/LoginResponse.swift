//
//  LoginResponse.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

class LoginResponse: Decodable {
    var token: String
    var profile: ProfileDecodable
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        token = try values.decode(String.self, forKey: .token)
        profile = try values.decode(ProfileDecodable.self, forKey: .profile)
    }
    
    private enum CodingKeys: String, CodingKey {
        case token
        case profile
      }
}

//
//  LoginResponse.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

protocol LoginResponse {
    var token: String { get set }
    var profile: Profile { get set }
}

class LoginDecodableResponse: LoginResponse, Decodable {
    var token: String
    
    var profile: Profile
    
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

//
//  LoginResponse.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

class LoginResponse: Decodable {
    var token: String
    var profile: Profile
}

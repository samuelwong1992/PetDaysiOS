//
//  LoginResponse.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

protocol LoginResponse: Decodable {
    var token: String { get set }
    var profile: ProfileDecodable { get set }
}

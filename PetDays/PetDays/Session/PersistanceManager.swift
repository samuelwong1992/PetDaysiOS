//
//  PersistanceManager.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import Foundation

protocol PersistanceManager {
    func getAPIToken() -> String?
    func saveAPIToken(token: String)
    func clearAPIToken()
}

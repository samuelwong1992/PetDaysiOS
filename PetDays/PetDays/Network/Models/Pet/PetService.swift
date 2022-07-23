//
//  PetService.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation
import UIKit

protocol PetService {
    func create(withName name: String, profilePicture: UIImage?, completion: @escaping(_ error: Error?) -> Void)
    func requestDaycare(forPet pet: Pet, daycare: Daycare, completion: @escaping(_ error: Error?) -> Void)
}

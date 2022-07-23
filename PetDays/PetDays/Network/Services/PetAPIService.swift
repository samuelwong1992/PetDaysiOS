//
//  PetAPIService.swift
//  PetDays
//
//  Created by Samuel Wong on 22/7/2022.
//

import Foundation
import UIKit

class PetAPIService: PetService {
    func create(withName name: String, profilePicture: UIImage?, completion: @escaping(_ error: Error?) -> Void) {
        let request = PetAPI.create(name: name, image: profilePicture)
        APIManager.current.performRequest(request: request, shouldShowLoading: true) { (model: Pet?, error) in
            guard error == nil else { return completion(error) }
            guard let pet = model else { return completion(NSError.standardNoDataError()) }
            
            SessionManager.current.profile?.pets.append(pet)
            return completion(nil)
        }
    }
    
    func requestDaycare(forPet pet: Pet, daycare: Daycare, completion: @escaping(_ error: Error?) -> Void) {
        let request = PetAPI.requestDaycare(petId: pet.id, daycareId: daycare.id)
        APIManager.current.performRequest(request: request, shouldShowLoading: true) { (model: Daycare?, error) in
            guard error == nil else { return completion(error) }
            guard let daycare = model else { return completion(NSError.standardNoDataError()) }
            
            SessionManager.current.profile?.daycares.append(daycare)
            return completion(nil)
        }
    }
}

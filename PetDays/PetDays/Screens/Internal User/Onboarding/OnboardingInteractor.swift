//
//  OnboardingInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation
import UIKit

class OnboardingInteractor: Presenterable {
    var presenter: OnboardingScreen!
    
    var petService: PetService
    
    internal init(petService: PetService) {
        self.petService = petService
    }
}

//MARK: API Handling
extension OnboardingInteractor {
    func createPet(name: String, image: UIImage?, completion: @escaping((Bool) -> Void)) {
        petService.create(withName: name, profilePicture: image) { error in
            guard error == nil else { UIAlertController.showAlertWithError(viewController: self.presenter.viewController, error: error!); return completion(false) }
            
            return completion(true)
        }
    }
    
    func requestDaycare(pet: Pet, daycare: Daycare, completion: @escaping((Bool) -> Void)) {
        petService.requestDaycare(forPet: pet, daycare: daycare) { error in
            guard error == nil else { UIAlertController.showAlertWithError(viewController: self.presenter.viewController, error: error!); return completion(false) }
            
            return completion(true)
        }
    }
}

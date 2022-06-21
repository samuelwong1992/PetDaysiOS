//
//  OnboardingInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation
import UIKit

class OnboardingInteractor: ScreenComponent {
    var screen: OnboardingScreen!
}

//MARK: API Handling
extension OnboardingInteractor {
    func createPet(name: String, image: UIImage?, completion: @escaping((Bool) -> Void)) {
        Pet.create(withName: name, profilePicture: image) { error in
            guard error == nil else { UIAlertController.showAlertWithError(viewController: self.screen.viewController, error: error!); return completion(false) }
            
            return completion(true)
        }
    }
    
    func requestDaycare(pet: Pet, daycareId: Int, completion: @escaping((Bool) -> Void)) {
        pet.requestDaycare(daycareId: daycareId) { error in
            guard error == nil else { UIAlertController.showAlertWithError(viewController: self.screen.viewController, error: error!); return completion(false) }
            
            return completion(true)
        }
    }
}

//
//  LandingInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

class LandingInteractor: Presenterable {
    var presenter: LandingScreen!
    
    var userService: UserService
    var persistanceManager: PersistanceManager {
        return userService.persistanceManager
    }
    
    internal init(userService: UserService) {
        self.userService = userService
    }
}

extension LandingInteractor {
    func viewDidLoad() {
        if let _ = self.persistanceManager.getAPIToken() {
            userService.login(username: "", password: "") { error in
                guard error == nil else {
                    self.persistanceManager.clearAPIToken()
                    return
                }
                self.presenter.router.goToHomeScreen()
            }
        } else {
            self.presenter.router.goToLoginScreen()
        }
    }
}

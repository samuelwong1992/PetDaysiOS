//
//  LoginInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

class LoginInteractor: ScreenComponent {
    var screen: LoginScreen!
    
    var userService: UserService
    
    internal init(userService: UserService) {
        self.userService = userService
    }
}

extension LoginInteractor {
    func login(username: String, password: String) {
        userService.login(username: username, password: password) { error in
            guard error == nil else { self.screen.viewController.showError(error: error!); return }
            
            self.screen.router.goToHomeScreen()
        }
    }
    
    func register(username: String, password: String, password2: String, firstName: String, lastName: String) {
        userService.register(username: username, password: password, password2: password2, firstName: firstName, lastName: lastName) { error in
            guard error == nil else { self.screen.viewController.showError(error: error!); return }
            
            self.screen.router.goToHomeScreen()
        }
    }
}

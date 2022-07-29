//
//  LoginInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

class LoginInteractor: Presenterable {
    var presenter: LoginPresenter!
    
    var userService: UserService
    
    internal init(userService: UserService) {
        self.userService = userService
    }
}

extension LoginInteractor {
    func login(username: String, password: String) {
        userService.login(username: username, password: password) { error in
            guard error == nil else { self.presenter.viewController.showError(error: error!); return }
            
            self.presenter.successfullyLoggedIn()
        }
    }
    
    func register(username: String, password: String, password2: String, firstName: String, lastName: String) {
        userService.register(username: username, password: password, password2: password2, firstName: firstName, lastName: lastName) { error in
            guard error == nil else { self.presenter.viewController.showError(error: error!); return }
            
            self.presenter.successfullyLoggedIn()
        }
    }
}

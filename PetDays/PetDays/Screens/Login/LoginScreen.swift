//
//  LoginScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

class LoginScreen {
    var viewController: LoginViewController
    var interactor: LoginInteractor
    var router: LoginRouter
    
    init(router: LoginRouter) {
        self.viewController = LoginViewController.viewController!
        self.interactor = LoginInteractor(userService: UserAPIService(persistanceManager: KeychainManager(), storageManager: CompositeStorageManager.current))
        self.router = router
        
        viewController.setPresenter(presenter: self)
        interactor.setPresenter(presenter: self)
    }
}

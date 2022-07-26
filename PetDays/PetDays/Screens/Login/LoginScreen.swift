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
    var router: MainNavigationController
    
    init(router: MainNavigationController) {
        self.viewController = LoginViewController.viewController!
        self.interactor = LoginInteractor(userService: UserAPIService(persistanceManager: KeychainManager(), storageManager: CompositeStorageManager.current))
        self.router = router
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }
}

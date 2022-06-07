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
    var presenter: MainNavigationController
    
    init(presenter: MainNavigationController) {
        self.viewController = LoginViewController.viewController!
        self.interactor = LoginInteractor()
        self.presenter = presenter
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }
}

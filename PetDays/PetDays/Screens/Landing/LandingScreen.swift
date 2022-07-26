//
//  LandingScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LandingScreen {
    var viewController: LandingViewController
    var interactor: LandingInteractor
    var router: MainNavigationController
    
    init(router: MainNavigationController, userService: UserService) {
        self.viewController = LandingViewController.viewController!
        self.interactor = LandingInteractor(userService: userService)
        self.router = router
        
        viewController.setPresenter(presenter: self)
        interactor.setPresenter(presenter: self)
    }
}

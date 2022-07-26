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
    var presenter: LandingPresenter
    var router: MainNavigationController
    
    init(router: MainNavigationController, userService: UserService) {
        self.viewController = LandingViewController.viewController!
        self.interactor = LandingInteractor(userService: userService)
        self.router = router
        self.presenter = LandingPresenter(viewController: self.viewController, interactor: self.interactor, router: router)
    }
}

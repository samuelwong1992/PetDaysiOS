//
//  OnboardingScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation

class OnboardingScreen {
    var viewController: OnboardingViewController
    var interactor: OnboardingInteractor
    var router: InternalUserNavigationController
    
    init(router: InternalUserNavigationController) {
        self.viewController = OnboardingViewController.viewController!
        self.interactor = OnboardingInteractor(petService: PetAPIService())
        self.router = router
        
        viewController.setPresenter(presenter: self)
        interactor.setPresenter(presenter: self)
    }

}

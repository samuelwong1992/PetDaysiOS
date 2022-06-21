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
    var presenter: InternalUserNavigationController
    
    init(presenter: InternalUserNavigationController) {
        self.viewController = OnboardingViewController.viewController!
        self.interactor = OnboardingInteractor()
        self.presenter = presenter
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }

}

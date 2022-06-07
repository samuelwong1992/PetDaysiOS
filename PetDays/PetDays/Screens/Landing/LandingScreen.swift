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
    var presenter: MainNavigationController
    
    init(presenter: MainNavigationController) {
        self.viewController = LandingViewController.viewController!
        self.interactor = LandingInteractor()
        self.presenter = presenter
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }
}

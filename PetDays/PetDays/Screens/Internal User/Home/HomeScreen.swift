//
//  HomeScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation

class HomeScreen {
    var viewController: HomeViewController
    var interactor: HomeInteractor
    var router: InternalUserNavigationController
    
    init(router: InternalUserNavigationController) {
        self.router = router
        self.viewController = HomeViewController.viewController!
        self.interactor = HomeInteractor()
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }
}

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
    var presenter: InternalUserNavigationController
    
    init(presenter: InternalUserNavigationController) {
        self.presenter = presenter
        self.viewController = HomeViewController.viewController!
        self.interactor = HomeInteractor()
        
        viewController.setScreen(screen: self)
        interactor.setScreen(screen: self)
    }
}

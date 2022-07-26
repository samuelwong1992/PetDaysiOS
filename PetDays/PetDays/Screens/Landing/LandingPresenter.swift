//
//  LandingPresenter.swift
//  PetDays
//
//  Created by Samuel Wong on 26/7/2022.
//

import Foundation

class LandingPresenter: Presenter<LandingViewController, LandingInteractor> {
    private var router: MainNavigationController!
    
    init(viewController: LandingViewController, interactor: LandingInteractor, router: MainNavigationController) {
        super.init(viewController: viewController, interactor: interactor)
        
        self.router = router
    }
}

//MARK: Initialization
extension LandingPresenter {
    func viewDidLoad() {
        self.interactor.viewDidLoad()
    }
}

//MARK: Navigation
extension LandingPresenter {
    func goToHomeScreen() {
        self.router.goToHomeScreen()
    }
    
    func goToLoginScreen() {
        self.router.goToLoginScreen()
    }
}

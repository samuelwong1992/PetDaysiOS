//
//  LandingPresenter.swift
//  PetDays
//
//  Created by Samuel Wong on 26/7/2022.
//

import Foundation

class LandingPresenter: Presenter<LandingViewController, LandingInteractor> {
    private var router: LandingRouter!
    
    init(viewController: LandingViewController, interactor: LandingInteractor, router: LandingRouter) {
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

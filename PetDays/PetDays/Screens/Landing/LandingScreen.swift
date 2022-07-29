//
//  LandingScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LandingScreen {
    private init() {}
    
    static func buildModule(navigationController: UINavigationController, userService: UserService) -> LandingPresenter {
        return LandingPresenter(
            viewController: LandingViewController.viewController!,
            interactor: LandingInteractor(userService: userService),
            router: LandingRouter(navigationController: navigationController)
        )
    }
}

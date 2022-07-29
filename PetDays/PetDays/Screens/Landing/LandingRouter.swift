//
//  LandingRouter.swift
//  PetDays
//
//  Created by Samuel Wong on 29/7/2022.
//

import Foundation
import UIKit

class LandingRouter: GoToHomeRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginScreen.buildModule(navigationController: navigationController)
        loginScreen.viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(loginScreen.viewController, animated: true)
    }
}

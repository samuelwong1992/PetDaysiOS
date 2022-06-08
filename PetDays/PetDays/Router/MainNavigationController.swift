//
//  MainNavigationController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    static func createMainNavigationController() -> MainNavigationController {
        let mvc = MainNavigationController()
        let landingScreen = LandingScreen(presenter: mvc)
        mvc.setViewControllers([landingScreen.viewController], animated: false)
        return mvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginScreen(presenter: self)
        loginScreen.viewController.modalPresentationStyle = .overFullScreen
        self.present(loginScreen.viewController, animated: true)
    }
}

//
//  MainNavigationController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    static func createMainNavigationController() -> MainNavigationController {
        let mnc = MainNavigationController()
        let landingScreen = LandingScreen(router: mnc)
        mnc.setViewControllers([landingScreen.viewController], animated: false)
        return mnc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginScreen(router: self)
        loginScreen.viewController.modalPresentationStyle = .overFullScreen
        self.present(loginScreen.viewController, animated: true)
    }
    
    func goToHomeScreen() {
        let iunc = InternalUserNavigationController()
        let homeScreen = HomeScreen(router: iunc)
        iunc.setViewControllers([homeScreen.viewController], animated: false)
        iunc.modalPresentationStyle = .overFullScreen
        
        if(self.presentedViewController == nil) {
            self.present(iunc, animated: true)
        } else {
            self.dismiss(animated: true) {
                self.present(iunc, animated: true)
            }
        }
    }
}

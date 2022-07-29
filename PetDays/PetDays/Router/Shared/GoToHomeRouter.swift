//
//  GoToHomeRouter.swift
//  PetDays
//
//  Created by Samuel Wong on 29/7/2022.
//

import UIKit

protocol GoToHomeRouter {
    var navigationController: UINavigationController { get set }
    
    func goToHomeScreen()
}

extension GoToHomeRouter {
    func goToHomeScreen() {
        let iunc = InternalUserNavigationController()
        let homeScreen = HomeScreen(router: iunc)
        iunc.setViewControllers([homeScreen.viewController], animated: false)
        iunc.modalPresentationStyle = .overFullScreen
        
        if(navigationController.presentedViewController == nil) {
            navigationController.present(iunc, animated: true)
        } else {
            navigationController.dismiss(animated: true) {
                self.navigationController.present(iunc, animated: true)
            }
        }
    }
}

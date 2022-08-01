//
//  LoginScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginScreen {
    private init(router: LoginRouter) {}
    
    static func buildModule(navigationController: UINavigationController, userService: UserService) -> LoginPresenter {
        return LoginPresenter(
            viewController: LoginViewController.viewController!,
            interactor: LoginInteractor(userService: userService),
            router: LoginRouter(navigationController: navigationController)
        )
    }
}

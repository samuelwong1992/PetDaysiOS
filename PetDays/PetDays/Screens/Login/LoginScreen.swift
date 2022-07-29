//
//  LoginScreen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginScreen {
    private init(router: LoginRouter) {}
    
    static func buildModule(navigationController: UINavigationController) -> LoginPresenter {
        return LoginPresenter(
            viewController: LoginViewController.viewController!,
            interactor: LoginInteractor(userService: UserAPIService(persistanceManager: KeychainManager(), storageManager: CompositeStorageManager.current)),
            router: LoginRouter(navigationController: navigationController)
        )
    }
}

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
        let landingScreen = LandingScreen.buildModule(
            navigationController: mnc,
            userService: UserAPIService(persistanceManager: KeychainManager(), storageManager: CompositeStorageManager.current)
        )
        mnc.setViewControllers([landingScreen.viewController], animated: false)
        return mnc
    }
}

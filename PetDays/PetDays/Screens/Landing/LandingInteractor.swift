//
//  LandingInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation

class LandingInteractor: ScreenComponent {
    var screen: LandingScreen!
}

extension LandingInteractor {
    func viewDidLoad() {
        if let token = KeychainManager.current.read(service: .APIAccessToken) {
            SessionManager.current.user = User(apiToken: token)
            User.login(username: "", password: "") { error in
                guard error == nil else {
                    KeychainManager.current.delete(service: .APIAccessToken)
                    return
                }
                self.screen.router.goToHomeScreen()
            }
        } else {
            self.screen.router.goToLoginScreen()
        }
    }
}

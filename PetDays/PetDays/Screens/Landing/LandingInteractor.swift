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
        self.screen.presenter.goToLoginScreen()
//        self.screen.presenter.goToHomeScreen()
    }
}

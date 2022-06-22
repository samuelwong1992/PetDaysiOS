//
//  HomeInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation

class HomeInteractor: ScreenComponent {
    var screen: HomeScreen!
}

//MARK: Initialization {
extension HomeInteractor {
    func viewDidLoad() {
        if SessionManager.current.profile?.pets.count == 0 || SessionManager.current.profile?.daycares.count == 0 {
            screen.router.goToOnboarding()
        }
    }
}

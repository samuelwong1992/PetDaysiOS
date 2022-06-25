//
//  HomeInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation
import UIKit

class HomeInteractor: ScreenComponent {
    var screen: HomeScreen!
}

//MARK: Initialization {
extension HomeInteractor {
    func viewDidLoad() {
        SessionManager.current.subscribe(toObserserve: .posts) {
            self.screen.viewController.reloadData()
        }
        
        if SessionManager.current.profile?.pets.count == 0 || SessionManager.current.profile?.daycares.count == 0 {
            screen.router.goToOnboarding()
        } else {
            Post.getFeed { error in
                guard error == nil else { UIAlertController.showAlertWithError(viewController: self.screen.viewController, error: error!); return }
            }
        }
    }
}

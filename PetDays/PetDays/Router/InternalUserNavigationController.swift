//
//  InternalUserNavigationController.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import UIKit

class InternalUserNavigationController: UINavigationController {

    static func createInternalUserNavigationController() -> InternalUserNavigationController {
        let iunc = InternalUserNavigationController()
        let landingScreen = HomeScreen(presenter: iunc)
        iunc.setViewControllers([landingScreen.viewController], animated: false)
        return iunc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = InternalNavBar(frame: self.navigationBar.frame)
        self.navigationBar.addSubViewWithSameSize(subview: navBar)
    }
}

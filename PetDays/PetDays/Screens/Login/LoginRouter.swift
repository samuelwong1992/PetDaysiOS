//
//  LoginRouter.swift
//  PetDays
//
//  Created by Samuel Wong on 29/7/2022.
//

import UIKit

class LoginRouter: GoToHomeRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

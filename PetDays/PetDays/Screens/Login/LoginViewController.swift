//
//  LoginViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginViewController: UIViewController, ScreenComponent {
    var screen: LoginScreen!

    static var viewController: LoginViewController? {
        return StoryboardConstants.Storyboards.Login.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.LoginViewController.identifier) as? LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

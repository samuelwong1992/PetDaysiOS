//
//  StoryboardConstants.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation
import UIKit

struct StoryboardConstants {
    enum Storyboards: String {
        case Landing = "Landing"
        case Login = "Login"
        case Main = "Main"
        case Internal = "Internal"
        
        var storyboard: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    enum ViewControllers: String {
        case LandingViewController = "LandingViewController"
        case LoginViewController = "LoginViewController"
        case MainViewController = "MainViewController"
        case HomeViewController = "HomeViewController"
        
        var identifier: String {
            return self.rawValue
        }
    }
    
    enum Nib: String {
        case LoginView = "LoginView"
        case SignUpView = "SignUpView"
        
        var identifier: String {
            return self.rawValue
        }
    }
}

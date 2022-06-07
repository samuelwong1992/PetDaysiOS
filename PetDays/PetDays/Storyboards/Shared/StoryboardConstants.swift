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
        
        var storyboard: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    enum ViewControllers: String {
        case LandingViewController = "LandingViewController"
        case LoginViewController = "LoginViewController"
        case MainViewController = "MainViewController"
        
        var identifier: String {
            return self.rawValue
        }
    }
}

//
//  HomeViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import UIKit

class HomeViewController: UIViewController, ScreenComponent {
    var screen: HomeScreen!
    
    static var viewController: HomeViewController? {
        return StoryboardConstants.Storyboards.Internal.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.HomeViewController.identifier) as? HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screen.interactor.viewDidLoad()
    }
}

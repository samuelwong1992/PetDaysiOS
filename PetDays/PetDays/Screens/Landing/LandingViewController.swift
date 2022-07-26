//
//  LandingViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LandingViewController: UIViewController, Presenterable {
    var presenter: LandingPresenter!
    
    static var viewController: LandingViewController? {
        return StoryboardConstants.Storyboards.Landing.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.LandingViewController.identifier) as? LandingViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        presenter.viewDidLoad()
    }
}

//MARK: Initialization
extension LandingViewController {
    func initialize() {
        
    }
}

//
//  HomeInteractor.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import Foundation
import UIKit

class HomeInteractor: Presenterable {
    var presenter: HomeScreen!
    
    var postService: PostService
    
    internal init(postService: PostService) {
        self.postService = postService
    }
}

//MARK: Initialization {
extension HomeInteractor {
    func viewDidLoad() {
        setupBindings()
        
        if SessionManager.current.profile?.pets.count == 0 || SessionManager.current.profile?.daycares.count == 0 {
            presenter.router.goToOnboarding()
        } else {
            getFeed()
        }
    }
    
    func setupBindings() {
        SessionManager.current.subscribe(toObserserve: .posts) {
            self.presenter.viewController.reloadData()
        }
        
        SessionManager.current.subscribe(toObserserve: .daycare) { [weak self] in
            self?.getFeed()
        }
        
        SessionManager.current.subscribe(toObserserve: .pet) { [weak self] in
            self?.getFeed()
        }
    }
}

//MARK: Utilities
extension HomeInteractor {
    func getFeed() {
        postService.getFeed { error in
            guard error == nil else { UIAlertController.showAlertWithError(viewController: self.presenter.viewController, error: error!); return }
        }
    }
}

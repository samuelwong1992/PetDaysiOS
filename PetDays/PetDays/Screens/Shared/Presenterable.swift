//
//  Screen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation
import UIKit

protocol Presenterable: AnyObject {
    associatedtype T
    var presenter: T! { get set }
    func setPresenter(presenter: T)
}

extension Presenterable {
    func setPresenter(presenter: T) {
        self.presenter = presenter
    }
}

class Presenter<vcType: Presenterable, interactorType: Presenterable> {
    var viewController: vcType
    var interactor: interactorType

    init(viewController: vcType, interactor: interactorType) {
        self.viewController = viewController
        self.interactor = interactor

        viewController.setPresenter(presenter: self as! vcType.T)
        interactor.setPresenter(presenter: self as! interactorType.T)
    }

    private func getViewController() -> vcType {
        return viewController
    }

    private func getInteractor() -> interactorType {
        return interactor
    }
}

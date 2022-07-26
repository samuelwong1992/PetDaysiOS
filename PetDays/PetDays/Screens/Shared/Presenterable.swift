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

//
//  Screen.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation
import UIKit

protocol ScreenComponent: AnyObject {
    associatedtype T
    var screen: T! { get set }
    func setScreen(screen: T)
}

extension ScreenComponent {
    func setScreen(screen: T) {
        self.screen = screen
    }
}

//
//  WelcomeView.swift
//  PetDays
//
//  Created by Samuel Wong on 20/6/2022.
//

import UIKit

class WelcomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.WelcomeView.identifier, forClass: WelcomeView.self)
    }
}

//MARK: Onboarding Component Conforming
extension WelcomeView: OnboardingComponent {
    func onboardingComponentIsValid() -> Bool {
        return true
    }
}

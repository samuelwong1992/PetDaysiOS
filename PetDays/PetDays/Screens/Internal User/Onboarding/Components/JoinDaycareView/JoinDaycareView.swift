//
//  JoinDaycareView.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

class JoinDaycareView: UIView {
    var selectedDaycare: Daycare? {
        get {
            return Daycare(id: 1, name: "")
        }
    }
    var selectedPet: Pet?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.JoinDaycareView.identifier, forClass: JoinDaycareView.self)
    }
}

//MARK: Onboarding Component Conforming
extension JoinDaycareView: OnboardingComponent {
    func onboardingComponentIsValid() -> Bool {
        guard selectedPet != nil else { return false }
        guard selectedDaycare != nil else { return false }
        
        return true
    }
}

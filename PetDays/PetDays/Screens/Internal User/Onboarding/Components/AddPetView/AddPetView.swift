//
//  AddPetView.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

class AddPetView: UIView {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameInputField: TitledTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.AddPetView.identifier, forClass: AddPetView.self)
        
        initialize()
    }
}

//MARK: Initialization
extension AddPetView {
    func initialize() {
        profilePictureImageView.backgroundColor = .gray
        profilePictureImageView.setRoundedCorners(large: true)
        profilePictureImageView.addBorder(thick: true, colour: Theme.Colours.primary.color)
    }
}

//MARK: Onboarding Component Conforming
extension AddPetView: OnboardingComponent {
    func onboardingComponentIsValid() -> Bool {
        guard nameInputField.validate(criteria: [.NotEmpty]) else { return false }
        return true
    }
}

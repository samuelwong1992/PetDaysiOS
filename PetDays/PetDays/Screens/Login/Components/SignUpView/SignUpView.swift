//
//  SignUpView.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class SignUpView: UIView {

    @IBOutlet weak var usernameField: TitledTextField!
    @IBOutlet weak var passwordField: TitledTextField!
    @IBOutlet weak var password2Field: TitledTextField!
    @IBOutlet weak var firstNameField: TitledTextField!
    @IBOutlet weak var lastNameField: TitledTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.SignUpView.identifier, forClass: SignUpView.self)
        
    }

}

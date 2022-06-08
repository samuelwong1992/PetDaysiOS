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
        
        initialize()
    }

}

//MARK: Initialization
extension SignUpView {
    func initialize() {
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        password2Field.isSecureTextEntry = true
    }
}

//MARK: Validation
extension SignUpView {
    func validate() -> Bool {
        var success = true
        
        success = usernameField.validate(criteria: [.NotEmpty]) && success
        success = passwordField.validate(criteria: [.NotEmpty]) && success
        success = password2Field.validate(criteria: [.NotEmpty, .MatchText(match: "password", comparator: passwordField.text)]) && success
        success = firstNameField.validate(criteria: [.NotEmpty]) && success
        success = lastNameField.validate(criteria: [.NotEmpty]) && success
        
        return success
    }
}

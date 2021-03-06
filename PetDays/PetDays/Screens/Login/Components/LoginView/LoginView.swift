//
//  LoginView.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginView: UIView {

    @IBOutlet weak var usernameField: TitledTextField!
    @IBOutlet weak var passwordField: TitledTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.LoginView.identifier, forClass: LoginView.self)
        
        initialize()
    }
}

//MARK: Initialization
extension LoginView {
    func initialize() {
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
    }
}

//MARK: Validation {
extension LoginView {
    func validate() -> Bool {
        var success = true
        success = usernameField.validate(criteria: [.NotEmpty]) && success
        success = passwordField.validate(criteria: [.NotEmpty]) && success
        
        return success
    }
}

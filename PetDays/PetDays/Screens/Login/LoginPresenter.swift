//
//  LoginPresenter.swift
//  PetDays
//
//  Created by Samuel Wong on 29/7/2022.
//

import UIKit

class LoginPresenter: Presenter<LoginViewController, LoginInteractor> {
    private var router: LoginRouter!
    
    init(viewController: LoginViewController, interactor: LoginInteractor, router: LoginRouter) {
        super.init(viewController: viewController, interactor: interactor)
        self.router = router
        
        initialize()
    }
    
    enum LoginViewMode {
        case login
        case signUp
    }
    
    private var currentViewMode: LoginViewMode? {
        didSet {
            switch currentViewMode {
            case nil :
                self.viewController.setNoModeSelected()
            case .login :
                self.viewController.setLoginModeSelected()
            case .signUp :
                self.viewController.setSignUpModeSelected()
            }
        }
    }
}

extension LoginPresenter {
    func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

extension LoginPresenter {
    func shouldLogin() {
        guard currentViewMode == .login else { currentViewMode = .login; return }
        let loginView = self.viewController.loginView
        guard loginView.validate() else { return }
        self.interactor.login(username: loginView.usernameField.text,
                                password: loginView.passwordField.text)
    }
    
    func shouldSignUp() {
        guard currentViewMode == .signUp else { currentViewMode = .signUp; return }
        let signUpView = self.viewController.signUpView
        guard signUpView.validate() else { return }
        self.interactor.register(username: signUpView.usernameField.text,
                                   password: signUpView.passwordField.text,
                                   password2: signUpView.password2Field.text,
                                   firstName: signUpView.firstNameField.text,
                                   lastName: signUpView.lastNameField.text)
    }
    
    func successfullyLoggedIn() {
        self.router.goToHomeScreen()
    }
}

extension LoginPresenter {
    func setCurrentViewMode(viewMode: LoginViewMode?) {
        self.currentViewMode = viewMode
    }
}

//MARK: Keyboard Handler
@objc extension LoginPresenter {
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            DispatchQueue.main.async {
                self.viewController.animateFormContainerViewBottomConstraint(toConstant: keyboardHeight + 40 + 24)
                switch self.currentViewMode {
                case .login :
                    self.viewController.animateLoginButtonBottomConstraint(toConstant: keyboardHeight)
                case .signUp :
                    self.viewController.animateSignUpButtonBottomConstraint(toConstant: keyboardHeight)
                default :
                    break
                }
            }
        }
    }
}

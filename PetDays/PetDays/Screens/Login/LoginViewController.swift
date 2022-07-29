//
//  LoginViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginViewController: UIViewController, Presenterable {
    var presenter: LoginPresenter!

    static var viewController: LoginViewController? {
        return StoryboardConstants.Storyboards.Login.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.LoginViewController.identifier) as? LoginViewController
    }
    
    @IBOutlet weak private var closeButton: UIButton!
    @IBOutlet weak private var loginButton: PrimaryButton!
    @IBOutlet weak private var signUpButton: SecondaryButton!
    @IBOutlet weak private var formContainerView: UIView!
    
    @IBOutlet private weak var formContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loginButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var signUpButtonBottomConstraint: NSLayoutConstraint!
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: self.view.frame)
        return loginView
    }()
    lazy var signUpView: SignUpView = {
        let signUpView = SignUpView(frame: self.view.frame)
         return signUpView
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        initialize()
    }
}

//MARK: Initialization
extension LoginViewController {
    func initialize() {
        closeButton.isHidden = true
        closeButton.addTarget(self, action: #selector(closeButton_didPress), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButton_didPress), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButton_didPress), for: .touchUpInside)
    }
}

//MARK: UI Layout
extension LoginViewController {
    func setNoModeSelected() {
        closeButton.animateHidden(hidden: true)
        loginView.animateHidden(hidden: true) {
            self.loginView.removeFromSuperview()
        }
        signUpView.animateHidden(hidden: true) {
            self.signUpView.removeFromSuperview()
        }
        self.resignFirstResponder()
        self.loginButtonBottomConstraint.animateToConstant(newConstant: 24 + 40 + 24, onView: self.view)
        self.signUpButtonBottomConstraint.animateToConstant(newConstant: 24, onView: self.view)
        self.formContainerViewBottomConstraint.animateToConstant(newConstant: 24 + 40 + 24 + 40 + 24, onView: self.view)
    }
    
    func setLoginModeSelected() {
        closeButton.animateHidden(hidden: false)
        formContainerView.addSubViewWithSameSize(subview: loginView)
        loginView.animateHidden(hidden: false)
        loginView.usernameField.becomeFirstResponder()
    }
    
    func setSignUpModeSelected() {
        closeButton.animateHidden(hidden: false)
        formContainerView.addSubViewWithSameSize(subview: signUpView)
        signUpView.animateHidden(hidden: false)
        signUpView.usernameField.becomeFirstResponder()
    }
}

//MARK: Interactor Methods
extension LoginViewController {
    func showError(error: Error) {
        UIAlertController.showAlertWithError(viewController: self, error: error)
    }
}

//MARK: Button Handlers
@objc extension LoginViewController {
    func closeButton_didPress() {
        self.presenter.setCurrentViewMode(viewMode: nil)
    }
    
    func loginButton_didPress() {
        self.presenter.shouldLogin()
    }
    
    func signUpButton_didPress() {
        self.presenter.shouldSignUp()
    }
}

//MARK: Keyboard Handler
@objc extension LoginViewController {    
    func animateFormContainerViewBottomConstraint(toConstant constant: CGFloat) {
        self.formContainerViewBottomConstraint.animateToConstant(newConstant: constant, onView: self.view)
    }
    
    func animateLoginButtonBottomConstraint(toConstant constant: CGFloat) {
        self.loginButtonBottomConstraint.animateToConstant(newConstant: constant, onView: self.view)
    }
    
    func animateSignUpButtonBottomConstraint(toConstant constant: CGFloat) {
        self.signUpButtonBottomConstraint.animateToConstant(newConstant: constant, onView: self.view)
    }
}

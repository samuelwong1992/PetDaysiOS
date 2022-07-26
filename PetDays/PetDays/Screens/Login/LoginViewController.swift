//
//  LoginViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

class LoginViewController: UIViewController, Presenterable {
    var presenter: LoginScreen!

    static var viewController: LoginViewController? {
        return StoryboardConstants.Storyboards.Login.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.LoginViewController.identifier) as? LoginViewController
    }
    
    @IBOutlet weak private var closeButton: UIButton!
    @IBOutlet weak private var loginButton: PrimaryButton!
    @IBOutlet weak private var signUpButton: SecondaryButton!
    @IBOutlet weak private var formContainerView: UIView!
    
    @IBOutlet weak var formContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonBottomConstraint: NSLayoutConstraint!
    
    private lazy var loginView: LoginView = {
        let loginView = LoginView(frame: self.view.frame)
        return loginView
    }()
    private lazy var signUpView: SignUpView = {
        let signUpView = SignUpView(frame: self.view.frame)
         return signUpView
     }()
    
    private enum ViewMode {
        case login
        case signUp
    }
    
    private var currentViewMode: ViewMode? {
        didSet {
            switch currentViewMode {
            case nil :
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
            case .login :
                closeButton.animateHidden(hidden: false)
                formContainerView.addSubViewWithSameSize(subview: loginView)
                loginView.animateHidden(hidden: false)
                loginView.usernameField.becomeFirstResponder()
            case .signUp :
                closeButton.animateHidden(hidden: false)
                formContainerView.addSubViewWithSameSize(subview: signUpView)
                signUpView.animateHidden(hidden: false)
                signUpView.usernameField.becomeFirstResponder()
            }
        }
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
        currentViewMode = nil
    }
    
    func loginButton_didPress() {
        guard currentViewMode == .login else { currentViewMode = .login; return }
        guard loginView.validate() else { return }
        presenter.interactor.login(username: loginView.usernameField.text,
                                password: loginView.passwordField.text)
    }
    
    func signUpButton_didPress() {
        guard currentViewMode == .signUp else { currentViewMode = .signUp; return }
        guard signUpView.validate() else { return }
        presenter.interactor.register(username: signUpView.usernameField.text,
                                   password: signUpView.passwordField.text,
                                   password2: signUpView.password2Field.text,
                                   firstName: signUpView.firstNameField.text,
                                   lastName: signUpView.lastNameField.text)
    }
}

//MARK: Keyboard Handler
@objc extension LoginViewController {
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            DispatchQueue.main.async {
                self.formContainerViewBottomConstraint.animateToConstant(newConstant: keyboardHeight + 40 + 24, onView: self.view)
                switch self.currentViewMode {
                case .login :
                    self.loginButtonBottomConstraint.animateToConstant(newConstant: keyboardHeight, onView: self.view)
                case .signUp :
                    self.signUpButtonBottomConstraint.animateToConstant(newConstant: keyboardHeight, onView: self.view)
                default :
                    break
                }
            }
        }
    }
}

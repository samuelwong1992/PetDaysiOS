//
//  OnboardingViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

class OnboardingViewController: UIViewController, ScreenComponent {

    var screen: OnboardingScreen!
    
    static var viewController: OnboardingViewController? {
        return StoryboardConstants.Storyboards.Internal.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.OnboardingViewController.identifier) as? OnboardingViewController
    }
    
    enum State: Int {
        case Welcome = 0
        case AddPet
        case JoinDaycare
        
        func view(forVC vc: OnboardingViewController) -> OnboardingComponent {
            switch self {
            case .Welcome :
                return vc.welcomeView
            case .AddPet :
                return vc.addPetView
            case .JoinDaycare :
                return vc.joinDaycareView
            }
        }
        
        func performRequest(forVC vc: OnboardingViewController, completion: @escaping ((Bool) -> Void)) {
            switch self {
            case .Welcome :
                return completion(true)
            case .AddPet :
                vc.screen.interactor.createPet(name: vc.addPetView.nameInputField.text, image: nil, completion: completion)
            case .JoinDaycare :
                vc.screen.interactor.requestDaycare(pet: vc.joinDaycareView.selectedPet!, daycareId: vc.joinDaycareView.selectedDaycare!.id, completion: completion)
            }
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: SecondaryButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    var currentStateIndex: Int = 0 {
        willSet {
            let newState = availableStates[newValue]
            containerView.addSubView(subview: newState.view(forVC: self), toTop: true, toBottom: true, toLeftEdge: true, marginLeft: self.containerView.frame.width, equalWidth: containerView)
            self.view.performTotalLayout()
            
            let currentLeftMarginConstraint = self.containerView.constraints.filter({ $0.firstAttribute == .leading && $0.firstItem === currentState.view(forVC: self) }).first
            let newLeftMarginConstraint = self.containerView.constraints.filter({ $0.firstAttribute == .leading && $0.firstItem === newState.view(forVC: self) }).first
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
                currentLeftMarginConstraint?.constant = -self.containerView.frame.width
                newLeftMarginConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    var currentState: State {
        get {
            return availableStates[currentStateIndex]
        }
    }
    
    lazy var availableStates: [State] = {
        var initialState: [State] = [.Welcome]
        if SessionManager.current.profile?.pets.count == 0 {
            initialState.append(.AddPet)
        }
        if SessionManager.current.profile?.daycares.count == 0 {
            initialState.append(.JoinDaycare)
        }
        return initialState
    }()
    
    lazy var welcomeView: WelcomeView = {
        return WelcomeView(frame: self.containerView.frame)
    }()
    
    lazy var addPetView: AddPetView = {
        return AddPetView(frame: self.containerView.frame)
    }()
    
    lazy var joinDaycareView: JoinDaycareView = {
        let jdv = JoinDaycareView(frame: self.containerView.frame)
        jdv.selectedPet = SessionManager.current.profile?.pets.first
        return jdv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension OnboardingViewController {
    func initialize() {
        containerView.addSubView(subview: currentState.view(forVC: self), toTop: true, toBottom: true, toLeftEdge: true, equalWidth: containerView)
        nextButton.addTarget(self, action: #selector(nextButton_didPress), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addDismissKeyboardRecognizer()
    }
}

//MARK: Button Handlers
@objc extension OnboardingViewController {
    func nextButton_didPress() {
        self.view.dismissKeyboard()
        
        if currentState.view(forVC: self).onboardingComponentIsValid() {
            currentState.performRequest(forVC: self) { [weak self] success in
                guard success else { return }
                guard let sInstance = self else { return }
                
                if sInstance.currentStateIndex == sInstance.availableStates.count - 1 {
                    sInstance.dismiss(animated: true)
                } else {
                    sInstance.currentStateIndex += 1
                }
            }
        }
    }
}

//MARK: Keyboard Handler
@objc extension OnboardingViewController {
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            DispatchQueue.main.async {
                self.nextButtonBottomConstraint.animateToConstant(newConstant: keyboardHeight + 8, onView: self.view)
            }
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        self.nextButtonBottomConstraint.animateToConstant(newConstant: 40, onView: self.view)
    }
}

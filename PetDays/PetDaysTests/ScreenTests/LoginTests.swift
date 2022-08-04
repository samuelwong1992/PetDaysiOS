//
//  LoginTests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 29/7/2022.
//

import XCTest
@testable import PetDays

class LoginTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        RunLoop.current.run(until: Date())
    }

    func test_loginViewShows() throws {
        let testNavigationController = UINavigationController()
        let sut = LoginScreen.buildModule(
            navigationController: testNavigationController,
            userService: UserTestService(
                persistanceManager: TestPersistanceManager(withExistingToken: false),
                succeeds: true
            )
        )
        
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNil(sut.viewController.signUpView.superview)
        sut.viewController.loginButton_didPress()
        XCTAssertNotNil(sut.viewController.loginView.superview)
        XCTAssertNil(sut.viewController.signUpView.superview)
    }
    
    func test_signUpViewShows() throws {
        let testNavigationController = UINavigationController()
        let sut = LoginScreen.buildModule(
            navigationController: testNavigationController,
            userService: UserTestService(
                persistanceManager: TestPersistanceManager(withExistingToken: false),
                succeeds: true
            )
        )
        
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNil(sut.viewController.signUpView.superview)
        sut.viewController.signUpButton_didPress()
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNotNil(sut.viewController.signUpView.superview)
    }
    
    func test_signUpViewHides() throws {
        let testNavigationController = UINavigationController()
        let sut = LoginScreen.buildModule(
            navigationController: testNavigationController,
            userService: UserTestService(
                persistanceManager: TestPersistanceManager(withExistingToken: false),
                succeeds: true
            )
        )
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut.viewController
        window.isHidden = false
        
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNil(sut.viewController.signUpView.superview)
        sut.viewController.signUpButton_didPress()
        
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNotNil(sut.viewController.signUpView.superview)
        sut.viewController.closeButton_didPress()
        
        XCTAssertEqual(sut.viewController.signUpView.alpha, 0)
        XCTAssertEqual(sut.viewController.loginView.alpha, 0)
    }
    
    func test_loginViewHides() throws {
        let testNavigationController = UINavigationController()
        let sut = LoginScreen.buildModule(
            navigationController: testNavigationController,
            userService: UserTestService(
                persistanceManager: TestPersistanceManager(withExistingToken: false),
                succeeds: true
            )
        )
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut.viewController
        window.isHidden = false
        
        XCTAssertNil(sut.viewController.loginView.superview)
        XCTAssertNil(sut.viewController.signUpView.superview)
        sut.viewController.loginButton_didPress()
        
        XCTAssertNil(sut.viewController.signUpView.superview)
        XCTAssertNotNil(sut.viewController.loginView.superview)
        sut.viewController.closeButton_didPress()
        
        XCTAssertEqual(sut.viewController.signUpView.alpha, 0)
        XCTAssertEqual(sut.viewController.loginView.alpha, 0)
    }
    
    func test_validateLoginView() throws {
        let sut = LoginView()
        
        XCTAssertFalse(sut.validate())
        sut.usernameField.text = "some data"
        sut.passwordField.text = ""
        XCTAssertFalse(sut.validate())
        sut.usernameField.text = ""
        sut.passwordField.text = "some data"
        XCTAssertFalse(sut.validate())
        sut.usernameField.text = "some data"
        sut.passwordField.text = "some data"
        XCTAssertTrue(sut.validate())
    }
    
    func test_validateSignUpView_MissingData() throws {
        let sut = SignUpView(frame: CGRect(x: 0, y: 0, width: 500, height: 1000))
        
        let textFields: [TitledTextField] = [
            sut.usernameField,
            sut.passwordField,
            sut.password2Field,
            sut.firstNameField,
            sut.lastNameField,
        ]
        
        for i in 1..<textFields.count {
            recursivelySetTextFields(textFields: textFields, index: 0, remainder: i) {
                XCTAssertFalse(sut.validate())
            }
        }
        
        for textField in textFields {
            textField.text = "some data"
        }
        
        XCTAssertTrue(sut.validate())
    }
    
    func recursivelySetTextFields(textFields: [TitledTextField], index: Int, remainder: Int, completionBlock: (() -> Void)) {
        if remainder == 0 {
            completionBlock()
            textFields[index-1].text = ""
        } else {
            for i in index ..< textFields.count {
                textFields[i].text = "some data"
                recursivelySetTextFields(textFields: textFields, index: i + 1, remainder: remainder - 1, completionBlock: completionBlock)
                textFields[i].text = ""
            }
        }
    }
    
    func test_validateSignUpView_MismatchedPasswords() throws {
        let sut = SignUpView(frame: CGRect(x: 0, y: 0, width: 500, height: 1000))
        
        sut.usernameField.text = "some data"
        sut.firstNameField.text = "some data"
        sut.lastNameField.text = "some data"
        
        sut.passwordField.text = "matching data"
        sut.password2Field.text = "matching data"
        
        XCTAssertTrue(sut.validate())
        
        sut.passwordField.text = "mismatching data 1"
        sut.password2Field.text = "mismatched data 2"
        
        XCTAssertFalse(sut.validate())
    }
}

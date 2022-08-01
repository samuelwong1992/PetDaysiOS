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
}

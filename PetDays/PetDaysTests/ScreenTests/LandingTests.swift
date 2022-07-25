//
//  LandingTests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 20/6/2022.
//

import XCTest
@testable import PetDays

class LandingTests: XCTestCase {

    private var authToken: String = "4eea98cd74fa92de2c9494a42b3e703c5d54c021"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_canInitNoToken() throws {
        let mnc = MainNavigationController()
        let landingScreen = LandingScreen(router: mnc, userService: UserTestService(persistanceManager: TestPersistanceManager(withExistingToken: false), succeeds: true))
        mnc.setViewControllers([landingScreen.viewController], animated: false)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = mnc
        
        let _ = try XCTUnwrap(mnc.topViewController as? LandingViewController)
        let result = XCTWaiter.wait(for: [expectation(description: "Wait For UI Update")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            let _ = try XCTUnwrap(mnc.presentedViewController as? LoginViewController)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_canInitWithToken() throws {
        let mnc = MainNavigationController()
        let landingScreen = LandingScreen(router: mnc, userService: UserTestService(persistanceManager: TestPersistanceManager(withExistingToken: true), succeeds: true))
        mnc.setViewControllers([landingScreen.viewController], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = mnc
        let _ = try XCTUnwrap(mnc.topViewController as? LandingViewController)
        let result = XCTWaiter.wait(for: [expectation(description: "Wait For UI Update")], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            let iunc = try XCTUnwrap(mnc.presentedViewController as? InternalUserNavigationController)
            let _ = try XCTUnwrap(iunc.topViewController as? HomeViewController)
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

class TestPersistanceManager: PersistanceManager {
    var withExistingToken: Bool
    
    internal init(withExistingToken: Bool) {
        self.withExistingToken = withExistingToken
    }
    
    
    func getAPIToken() -> String? {
        return self.withExistingToken ? "Some Token" : nil
    }
    
    func saveAPIToken(token: String) {
        self.withExistingToken = true
    }
    
    func clearAPIToken() {
        self.withExistingToken = false
    }
}

class UserTestService: UserService {
    var persistanceManager: PersistanceManager
    var succeeds: Bool
    
    internal init(persistanceManager: PersistanceManager, succeeds: Bool) {
        self.persistanceManager = persistanceManager
        self.succeeds = succeeds
    }
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        if succeeds {
            persistanceManager.saveAPIToken(token: "Some Token")
            return completion(nil)
        } else {
            return completion(NSError.standardErrorWithString(errorString: "Some Error"))
        }
    }
    
    func register(username: String, password: String, password2: String, firstName: String, lastName: String, completion: @escaping (Error?) -> Void) {
        if succeeds {
            persistanceManager.saveAPIToken(token: "Some Token")
            return completion(nil)
        } else {
            return completion(NSError.standardErrorWithString(errorString: "Some Error"))
        }
    }
    
    
}

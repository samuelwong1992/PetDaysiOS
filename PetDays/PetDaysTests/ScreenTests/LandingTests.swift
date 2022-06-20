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
        KeychainManager.current.delete(service: .APIAccessToken)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_canInitNoToken() throws {
        let mnc = MainNavigationController.createMainNavigationController()
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
        KeychainManager.current.save(authToken, service: .APIAccessToken)
        let mnc = MainNavigationController.createMainNavigationController()
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

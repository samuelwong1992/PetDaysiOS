//
//  LandingTests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 20/6/2022.
//

import XCTest
@testable import PetDays

class LandingTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_canInitNoToken() throws {
        let mnc = NoAnimationMainNavigationController()
        let landingScreen = LandingScreen(router: mnc, userService: UserTestService(persistanceManager: TestPersistanceManager(withExistingToken: false), succeeds: true))
        mnc.setViewControllers([landingScreen.viewController], animated: false)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = mnc
        
        let lvc = try XCTUnwrap(mnc.topViewController as? LandingViewController)
        let _  = lvc.view // Triggers View Did Load
        let _ = try XCTUnwrap(mnc.presentedViewController as? LoginViewController)
    }
    
    func test_canInitWithToken() throws {
        let mnc = NoAnimationMainNavigationController()
        let landingScreen = LandingScreen(router: mnc, userService: UserTestService(persistanceManager: TestPersistanceManager(withExistingToken: true), succeeds: true))
        mnc.setViewControllers([landingScreen.viewController], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = mnc
        
        let lvc = try XCTUnwrap(mnc.topViewController as? LandingViewController)
        let _  = lvc.view // Triggers View Did Load
        let iunc = try XCTUnwrap(mnc.presentedViewController as? InternalUserNavigationController)
        let _ = try XCTUnwrap(iunc.topViewController as? HomeViewController)
    }
}

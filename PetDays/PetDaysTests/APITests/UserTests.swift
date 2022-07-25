//
//  APITests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 20/6/2022.
//

import XCTest
@testable import PetDays

class UserTests: XCTestCase {

    override func setUpWithError() throws {
        SessionManager.resetSessionManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func test_loginNoToken() throws {
//        KeychainManager.current.delete(service: .APIAccessToken)
//        User.login(username: "sam", password: "password") { error in
//            XCTAssertNil(error)
//            
//            XCTAssertNotNil(SessionManager.current.user)
//            XCTAssertNotNil(SessionManager.current.profile)
//            XCTAssertNotNil(KeychainManager.current.read(service:.APIAccessToken))
//        }
//    }
//    
//    func test_loginToken() throws {
//        KeychainManager.current.save("4eea98cd74fa92de2c9494a42b3e703c5d54c021", service: .APIAccessToken)
//        User.login(username: "", password: "") { error in
//            XCTAssertNil(error)
//            
//            XCTAssertNotNil(SessionManager.current.user)
//            XCTAssertNotNil(SessionManager.current.profile)
//            XCTAssertNotNil(KeychainManager.current.read(service:.APIAccessToken))
//        }
//    }
}

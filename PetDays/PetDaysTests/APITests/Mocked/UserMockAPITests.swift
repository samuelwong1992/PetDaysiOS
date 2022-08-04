//
//  UserMockAPITests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 26/7/2022.
//

import XCTest
@testable import PetDays

class UserMockAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_LoginSuccessful() throws {
        let persistanceManager = TestPersistanceManager(withExistingToken: false)
        UserAPIService(persistanceManager: persistanceManager, storageManager: LoginMockStorageManager(success: true)).login(username: "any", password: "any") { error in
            XCTAssertEqual(TestableLoginResponse.sampleToken, persistanceManager.getAPIToken())
            XCTAssertEqual(MockedJSON.Profile.sampleFirstName, SessionManager.current.profile?.firstName)
            XCTAssertEqual(MockedJSON.Profile.sampleLastName, SessionManager.current.profile?.lastName)
        }
    }
    
    func test_LoginFails() throws {
        let persistanceManager = TestPersistanceManager(withExistingToken: true)
        UserAPIService(persistanceManager: persistanceManager, storageManager: LoginMockStorageManager(success: false)).login(username: "any", password: "any") { error in
            XCTAssertEqual(nil, persistanceManager.getAPIToken())
        }
    }
}

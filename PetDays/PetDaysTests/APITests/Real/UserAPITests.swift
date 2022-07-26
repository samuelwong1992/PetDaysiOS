//
//  UserAPITests.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 20/6/2022.
//

import XCTest
@testable import PetDays

class UserAPITests: XCTestCase {

    override func setUpWithError() throws {
        TestableAPIManager.resetManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loginNoToken() throws {
        let apiManager = APIManager.testable(withExistingToken: false)
        let expectation = self.expectation(description: "login")
        
        let request = LoginAPI.login(username: "sam", password: "password")
        apiManager.performRequest(request: request, shouldShowLoading: false) { (response: LoginResponse?, error) in
            XCTAssertNil(error)
            
            XCTAssertNotNil(response)
            
            XCTAssertGreaterThan(response?.token.count ?? 0, 0)
            XCTAssertEqual(response?.profile.firstName, "Sam")
            XCTAssertEqual(response?.profile.lastName, "Wong")
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0)
    }
    
    func test_loginToken() throws {
        let apiManager = APIManager.testable(withExistingToken: true)
        let expectation = self.expectation(description: "login")
        
        let request = LoginAPI.login(username: "", password: "")
        apiManager.performRequest(request: request, shouldShowLoading: false) { (response: LoginResponse?, error) in
            XCTAssertNil(error)
            
            XCTAssertNotNil(response)
            
            XCTAssertGreaterThan(response?.token.count ?? 0, 0)
            XCTAssertEqual(response?.profile.firstName, "Sam")
            XCTAssertEqual(response?.profile.lastName, "Wong")
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 5.0)
    }
}

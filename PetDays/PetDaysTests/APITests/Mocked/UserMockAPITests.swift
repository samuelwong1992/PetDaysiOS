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
            XCTAssertEqual(TestableLoginResponse.sampleFirstName, SessionManager.current.profile?.firstName)
            XCTAssertEqual(TestableLoginResponse.sampleLastName, SessionManager.current.profile?.lastName)
        }
    }
    
    func test_LoginFails() throws {
        let persistanceManager = TestPersistanceManager(withExistingToken: true)
        UserAPIService(persistanceManager: persistanceManager, storageManager: LoginMockStorageManager(success: false)).login(username: "any", password: "any") { error in
            XCTAssertEqual(nil, persistanceManager.getAPIToken())
        }
    }
}

class LoginMockStorageManager: StorageManager {
    var success: Bool
    
    init(success: Bool) {
        self.success = success
    }
    
    func performRequest<T>(request: APIRequest, shouldShowLoading: Bool, completion: @escaping (T?, Error?) -> Void) where T : Decodable {
        if(success) {
            do {
                return try completion(TestableLoginResponse.sampleResponse() as? T, nil)
            } catch {
                return completion(nil, NSError.standardErrorWithString(errorString: "Sample Data Broken"))
            }
        } else {
            return completion(nil, NSError.standardErrorWithString(errorString: "Some error"))
        }
    }
}

class TestableLoginResponse {
    static let sampleToken = "some token"
    static let sampleFirstName = "Sam"
    static let sampleLastName = "Wong"
    
    static func sampleResponse() throws -> LoginResponse {
        let token = sampleToken
        let profile: [String:Any] = [
            "id" : 1,
            "first_name" : sampleFirstName,
            "last_name" : sampleLastName,
            "pets" : [],
            "daycares" : [],
        ]
        let responseDict: [String:Any] = [
            "token": token,
            "profile": profile
        ]
        let data = try JSONSerialization.data(withJSONObject: responseDict, options: [])
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
}

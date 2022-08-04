//
//  TestableLoginResponse.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 4/8/2022.
//

import Foundation
@testable import PetDays

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
    
    static func sampleResponse() throws -> LoginResponse {
        let token = sampleToken
        let profile = MockedJSON.Profile.createBasicProfile()
        
        let responseDict: [String:Any] = [
            "token": token,
            "profile": profile
        ]
        let data = try JSONSerialization.data(withJSONObject: responseDict, options: [])
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
}

//
//  MockedResponseJSON.swift
//  PetDaysTests
//
//  Created by Samuel Wong on 4/8/2022.
//

extension MockedJSON {
    struct Profile {
        static let sampleFirstName = "Sam"
        static let sampleLastName = "Wong"
        
        static func createBasicProfile() -> [String:Any] {
            return [
                "id" : 1,
                "first_name" : sampleFirstName,
                "last_name" : sampleLastName,
                "pets" : [],
                "daycares" : [],
            ]
        }
    }
}

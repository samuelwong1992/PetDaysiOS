//
//  APIObject.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

class APIObject: Decodable {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

extension APIObject: Equatable {
    static func ==(lhs: APIObject, rhs: APIObject) -> Bool {
        return lhs.id == rhs.id
    }
}


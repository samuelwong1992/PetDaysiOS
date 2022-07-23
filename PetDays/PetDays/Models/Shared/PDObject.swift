//
//  PDObject.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

class PDObject: Decodable {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

extension PDObject: Equatable {
    static func ==(lhs: PDObject, rhs: PDObject) -> Bool {
        return lhs.id == rhs.id
    }
}


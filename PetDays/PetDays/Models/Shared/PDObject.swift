//
//  PDObject.swift
//  PetDays
//
//  Created by Samuel Wong on 6/6/2022.
//

import Foundation

protocol PDObject {
    var id: Int { get set }
}

class PDDecodableObject: PDObject, Decodable {
    var id: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
      }
}

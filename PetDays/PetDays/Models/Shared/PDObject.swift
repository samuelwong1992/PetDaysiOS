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
    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int.self, forKey: .id)
//        try super.init(from: decoder)
//    }
    
    private enum CodingKeys: String, CodingKey {
        case id
      }
}

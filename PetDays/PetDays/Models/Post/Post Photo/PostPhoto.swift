//
//  PostPhoto.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import Foundation

class PostPhoto: PDObject {
    var photoUrl: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        photoUrl = try values.decode(String.self, forKey: .photo)
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case photo

    }
}

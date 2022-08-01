//
//  Post.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

protocol Post: PDObject {
    var employee: Employee { get set }
    var dateTimeCreated: Date? { get set }
    var text: String { get set }
    var postPhotos: [PostPhoto] { get set }
}

class PostDecodable: PDDecodableObject, Post {
    var employee: Employee
    var dateTimeCreated: Date?
    var text: String
    var postPhotos: [PostPhoto]
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        text = try values.decode(String.self, forKey: .text)
        employee = try values.decode(EmployeeDecodable.self, forKey: .employee)
        
        do {
            let dateTimeCreatedString = try values.decode(String.self, forKey: .dateTimeCreated)
            dateTimeCreated = dateTimeCreatedString.asDateFromDateTimeStamp()
        } catch {
            dateTimeCreated = nil
        }
        
        do {
            postPhotos = try values.decode([PostPhotoDecodable].self, forKey: .postPhotos)
        } catch {
            postPhotos = []
        }
        
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case daycare
        case employee
        case dateTimeCreated = "date_time_created"
        case text
        case postPhotos = "post_photos"
    }
}

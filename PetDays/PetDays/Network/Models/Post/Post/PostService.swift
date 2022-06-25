//
//  PostService.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

extension Post {
    static func getFeed(completion: @escaping (_ error: Error?) -> Void) {
        let request = PostAPI.getFeed(daycare: SessionManager.current.daycare, pet: SessionManager.current.pet)
        APIManager.current.performRequest(request: request) { (model: [Post]?, error) in
            guard error == nil else { return completion(error) }
            guard let posts = model else { return completion(NSError.standardNoDataError()) }
            
            SessionManager.current.posts = posts
        }
    }
}

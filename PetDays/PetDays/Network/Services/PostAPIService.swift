//
//  PostAPIService.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import Foundation

class PostAPIService: PostService {
    func getFeed(completion: @escaping (_ error: Error?) -> Void) {
        let request = PostAPI.getFeed(daycare: SessionManager.current.daycare, pet: SessionManager.current.pet)
        APIManager.current.performRequest(request: request, shouldShowLoading: false) { (model: [PostDecodable]?, error) in
            guard error == nil else { return completion(error) }
            guard let posts = model else { return completion(NSError.standardNoDataError()) }
            
            SessionManager.current.posts = posts
        }
    }
}

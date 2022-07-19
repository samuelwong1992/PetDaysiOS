//
//  PostTableViewCellModelView.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import Foundation
import UIKit

class PostTableViewCellModelView {
    private var post: Post
    var pagerParent: UIViewController
    
    init(post: Post, pagerParent: UIViewController) {
        self.post = post
        self.pagerParent = pagerParent
    }
    
    var titleText: String {
        return post.employee.daycare.name
    }
    
    var subtitleText: String {
        return post.employee.fullName
    }
    
    func getPrimaryImage(completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = post.employee.daycare.profilePictureUrl else { return completion(nil) }
        APIManager.current.fetchImageAtUrl(url: url, completion: completion)
    }
    
    func getSecondaryImage(completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = post.employee.profilePictureUrl else { return completion(nil) }
        APIManager.current.fetchImageAtUrl(url: url, completion: completion)
    }
    
    var mainText: String {
        return post.text
    }
    
    var postPhotos: [PostPhoto] {
        return post.postPhotos
    }
}

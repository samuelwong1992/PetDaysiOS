//
//  PostService.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

protocol PostService {
    func getFeed(completion: @escaping (_ error: Error?) -> Void)
}

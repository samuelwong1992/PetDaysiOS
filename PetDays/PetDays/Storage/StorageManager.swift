//
//  StorageManager.swift
//  PetDays
//
//  Created by Samuel Wong on 26/7/2022.
//

import Foundation

protocol StorageManager {
    func performRequest<T: Decodable>(request: APIRequest, shouldShowLoading: Bool, completion: @escaping (_ model: T?, _ error: Error?) -> Void)
}

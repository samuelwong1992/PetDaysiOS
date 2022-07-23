//
//  DaycareService.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import Foundation

protocol DaycareService {
    func search(desc: String, completion: @escaping((_ daycares: [Daycare], _ error: Error?) -> Void))
}

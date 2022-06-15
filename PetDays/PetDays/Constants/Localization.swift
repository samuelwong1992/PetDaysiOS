//
//  Localization.swift
//  PetDays
//
//  Created by Samuel Wong on 15/6/2022.
//

import Foundation

struct StandardStrings {
    enum Navigation {
        case FilterDaycareTitle
        case FilterPetsTitle
        case FilterDaycareMessage
        case FilterPetsMessage
        
        var string: String {
            switch self {
            case .FilterDaycareTitle : return "Filter Daycare"
            case .FilterPetsTitle : return "Filter Pet"
            case .FilterDaycareMessage : return "This will allow you to see the posts on a daycare by daycare basis"
            case .FilterPetsMessage : return "This will allow you to see the posts on a pet by pet basis"
            }
        }
    }
    
    enum Misc {
        case None
        case Cancel
        
        var string: String {
            switch self {
            case .None : return "None"
            case .Cancel : return "Cancel"
            }
        }
    }
}

//
//  Theme.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import Foundation
import UIKit

struct Theme {
    enum Colours {
        case primary
        
        case error
        
        case gray
        case white
        case black
        
        private var hexValue: String {
            switch self {
            case .primary : return "013220"
                
            case .error : return "FF0000"
                
            case .gray : return "D3D3D3"
            case .white : return "ffffff"
            case .black : return "000000"
            }
        }
        
        var color: UIColor {
            return UIColor.colourWithHexString(self.hexValue)
        }
    }
    
    enum CornerRadius: CGFloat {
        case regular = 4.0
        case large = 12.0
        
        var cgFloat: CGFloat {
            return self.rawValue
        }
    }
    
    enum Fonts {
        case focusTitle
        case focus
        case semiTitle
        case regular
        case detail
        
        var font: UIFont {
            switch self {
            case .focus : return UIFont.systemFont(ofSize: 20)
            case .focusTitle : return UIFont.boldSystemFont(ofSize: 20)
            case .semiTitle : return UIFont.boldSystemFont(ofSize: 14)
            case .regular : return UIFont.systemFont(ofSize: 14)
            case .detail : return UIFont.systemFont(ofSize: 12)
            }
        }
    }
}

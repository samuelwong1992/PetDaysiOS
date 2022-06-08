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
        
        case gray
        case white
        case black
        
        private var hexValue: String {
            switch self {
            case .primary : return "013220"
                
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
        
        var cgFloat: CGFloat {
            return self.rawValue
        }
    }
    
    enum Fonts {
        case semiTitle
        case regular
        case detail
        
        var font: UIFont {
            
            switch self {
            case .semiTitle : return UIFont.systemFont(ofSize: 16)
            case .regular : return UIFont.systemFont(ofSize: 14)
            case .detail : return UIFont.systemFont(ofSize: 12)
            }
        }
    }
}

//
//  Separator.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

@IBDesignable
class Separator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initialize()
    }
}

extension Separator {
    func initialize() {
        self.backgroundColor = Theme.Colours.gray.color
    }
}

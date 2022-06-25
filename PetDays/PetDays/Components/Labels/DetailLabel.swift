//
//  DetailLabel.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

@IBDesignable
class DetailLabel: UILabel {
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

extension DetailLabel {
    func initialize() {
        self.font = Theme.Fonts.detail.font
    }
}

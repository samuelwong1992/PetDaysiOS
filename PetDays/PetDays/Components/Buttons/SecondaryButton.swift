//
//  PrimaryButton.swift
//  PetDays
//
//  Created by Samuel Wong on 7/6/2022.
//

import UIKit

@IBDesignable class SecondaryButton: UIButton {
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

//MARK: Initialize
extension SecondaryButton {
    func initialize() {
        self.backgroundColor = Theme.Colours.white.color
        self.layer.borderWidth = 2
        self.layer.borderColor = Theme.Colours.primary.color.cgColor
        self.layer.cornerRadius = Theme.CornerRadius.regular.cgFloat
        self.tintColor = Theme.Colours.primary.color
    }
}

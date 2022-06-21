//
//  FocusLabels.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

@IBDesignable
class FocusTitleLabel: UILabel {
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

extension FocusTitleLabel {
    func initialize() {
        self.font = Theme.Fonts.focusTitle.font
    }
}

@IBDesignable
class FocusLabel: UILabel {
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

extension FocusLabel {
    func initialize() {
        self.font = Theme.Fonts.focus.font
    }
}

//
//  TitledTextView.swift
//  DriveIt
//
//  Created by Samuel Wong on 28/5/20.
//  Copyright © 2020 xPhase. All rights reserved.
//

import UIKit

protocol TitledTextViewDelegate {
    func didChangeText(forTitledTextView titledTextView: TitledTextView)
}

@IBDesignable class TitledTextView: UIView {
    private var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 14))
    private var textField = UITextView(frame: CGRect(x: 0, y: 0, width: 120, height: 24))
    
    private var titleLabelTopConstraint: NSLayoutConstraint!
    private var titleLabelHeightConstraint: NSLayoutConstraint!
    
    var _delegate: TitledTextViewDelegate?
    
    @IBInspectable var titleText: String! {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable var text: String! {
        didSet {
            if textField.text != text {
                textField.text = text
                textViewDidChange(textField)
            }
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    
    var _inputView: UIView? {
        didSet {
            textField.inputView = _inputView
        }
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override var isFirstResponder: Bool {
        get {
            return textField.isFirstResponder
        }
    }
    
    func equals(textField: UITextField) -> Bool {
        return textField == self.textField
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

       initialize()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        titleLabel.text = titleText
    }
}

//MARK: Initialization
extension TitledTextView {
    private func initialize() {
        self.addSubView(subview: textField, toTop: true, marginTop: 7, toBottom: true, toRightEdge: true, toLeftEdge: true)
        self.addSubView(subview: titleLabel, toLeftEdge: true, marginLeft: 8)
        textField.addBorder(colour: Theme.Colours.gray.color)
        textField.layer.cornerRadius = Theme.CornerRadius.regular.cgFloat
        textField.delegate = self
        textField.font = Theme.Fonts.regular.font
        titleLabel.backgroundColor = Theme.Colours.white.color
        titleLabel.textColor = Theme.Colours.gray.color
        titleLabel.font = Theme.Fonts.regular.font
        titleLabel.contentMode = .center
        titleText = "Title"
        
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14)
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 14)
        
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
        ])
    }
}

//MARK: Text Field Delegate
@objc extension TitledTextView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            if text.count != 0 {
                titleLabelTopConstraint.animateToConstant(newConstant: 0, onView: self)
                titleLabel.animate(font: Theme.Fonts.detail.font, duration: 0.4)
                titleLabelHeightConstraint.animateToActive(newActive: true, onView: self)
            } else {
                titleLabel.animate(font: Theme.Fonts.regular.font, duration: 0.4)
                titleLabelTopConstraint.animateToConstant(newConstant: 14, onView: self)
                titleLabelHeightConstraint.animateToActive(newActive: false, onView: self)
            }
        } else {
            titleLabel.animate(font: Theme.Fonts.regular.font, duration: 0.4)
            titleLabelTopConstraint.animateToConstant(newConstant: 14, onView: self)
            titleLabelHeightConstraint.animateToActive(newActive: false, onView: self)
        }
        
        self.text = textField.text
        _delegate?.didChangeText(forTitledTextView: self)
    }
}


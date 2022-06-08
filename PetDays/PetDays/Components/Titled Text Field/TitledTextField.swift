//
//  TitledTextField.swift
//  DriveIt
//
//  Created by Samuel Wong on 25/5/20.
//  Copyright © 2020 xPhase. All rights reserved.
//

import UIKit

protocol TitledTextFieldDelegate {
    func didChangeText(forTitledTextField titledTextField: TitledTextField)
}

protocol TitledTextFieldAutoCompleteDelegate {
    func titledTextField(titledTextField: TitledTextField, didSelectIndex index: Int)
}

@IBDesignable class TitledTextField: UIView {
    private var titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 14))
    private var textField = UITextField(frame: CGRect(x: 0, y: 0, width: 120, height: 24))
    
    private var titleLabelTopConstraint: NSLayoutConstraint!
    private var titleLabelBottomConstraint: NSLayoutConstraint!
    private var titleLabelHeightConstraint: NSLayoutConstraint!
    
    var _delegate: TitledTextFieldDelegate?
    var _autocompleteDelegate: TitledTextFieldAutoCompleteDelegate?
    
    @IBInspectable var titleText: String! {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    @IBInspectable var text: String! {
        didSet {
            if textField.text != text {
                textField.text = text
                textField_editingChanged(sender: textField)
            }
        }
    }
    
    private var forwardToDelegate: UITextFieldDelegate?
    var delegate: UITextFieldDelegate! {
        didSet {
            forwardToDelegate = delegate
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
    
    var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = autocorrectionType
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    var _inputView: UIView? {
        didSet {
            textField.inputView = _inputView
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
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
        
        initialize()
    }
}

//MARK: Initialization
extension TitledTextField {
    private func initialize() {
        self.addSubView(subview: textField, toTop: true, marginTop: 7, toBottom: true, toRightEdge: true, toLeftEdge: true)
        self.addSubView(subview: titleLabel, toLeftEdge: true, marginLeft: 8)
        
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textField_editingChanged(sender:)), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.delegate = self
        titleLabel.backgroundColor = Theme.Colours.white.color
        titleLabel.textColor = Theme.Colours.gray.color
        titleLabel.font = Theme.Fonts.regular.font
        titleLabel.contentMode = .center
        textField.backgroundColor = UIColor.white

        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        titleLabelBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 14)
        
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: 48)
        heightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabelBottomConstraint,
            heightConstraint
        ])
    }
}

//MARK: Text Field Delegate
@objc extension TitledTextField {
    func textField_editingChanged(sender: UITextField) {
        if let text = sender.text {
            if text.count != 0 {
                titleLabelTopConstraint.animateToConstant(newConstant: 0, onView: self)
                titleLabel.animate(font: Theme.Fonts.detail.font, duration: 0.4)
                titleLabelBottomConstraint.animateToActive(newActive: false, onView: self)
                titleLabelHeightConstraint.animateToActive(newActive: true, onView: self)
            } else {
                titleLabel.animate(font: Theme.Fonts.regular.font, duration: 0.4)
                titleLabelTopConstraint.animateToConstant(newConstant: 8, onView: self)
                titleLabelHeightConstraint.animateToActive(newActive: false, onView: self)
                titleLabelBottomConstraint.animateToActive(newActive: true, onView: self)
            }
        } else {
            titleLabel.animate(font: Theme.Fonts.regular.font, duration: 0.4)
            titleLabelTopConstraint.animateToConstant(newConstant: 8, onView: self)
            titleLabelHeightConstraint.animateToActive(newActive: false, onView: self)
            titleLabelBottomConstraint.animateToActive(newActive: true, onView: self)
        }
        
        self.text = textField.text
        _delegate?.didChangeText(forTitledTextField: self)
    }
}

//MARK: Text Field Delegate
extension TitledTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let forwardToDelegate = forwardToDelegate {
            forwardToDelegate.textFieldDidEndEditing?(textField)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let forwardToDelegate = forwardToDelegate {
            forwardToDelegate.textFieldDidBeginEditing?(textField)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let forwardToDelegate = forwardToDelegate {
            forwardToDelegate.textFieldDidChangeSelection?(textField)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let forwardToDelegate = forwardToDelegate {
            if let shouldClear = forwardToDelegate.textFieldShouldClear?(textField) {
                return shouldClear
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let forwardToDelegate = forwardToDelegate {
            if let shouldClear = forwardToDelegate.textFieldShouldReturn?(textField) {
                return shouldClear
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let forwardToDelegate = forwardToDelegate {
            if let shouldClear = forwardToDelegate.textFieldShouldEndEditing?(textField) {
                return shouldClear
            }
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let forwardToDelegate = forwardToDelegate {
            if let shouldClear = forwardToDelegate.textFieldShouldBeginEditing?(textField) {
                return shouldClear
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let forwardToDelegate = forwardToDelegate {
            forwardToDelegate.textFieldDidEndEditing?(textField)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let forwardToDelegate = forwardToDelegate {
            if let shouldClear = forwardToDelegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
                return shouldClear
            }
        }
        
        return true
    }
}

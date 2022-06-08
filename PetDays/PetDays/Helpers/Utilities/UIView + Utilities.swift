//
//  UIView + Utilities.swift
//  ChildcareApp
//
//  Created by Samuel Wong on 10/8/19.
//  Copyright © 2019 Samuel Wong. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib(_ nibName:String, forClass aClass: AnyClass! = nil, atIndex index:Int = 0) {
        let bundle:Bundle! = aClass != nil ? Bundle(for: aClass) : nil
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[index] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.clear
        addSubview(view)
        
        view.layoutIfNeeded()
        view.layoutSubviews()
    }
    
    func performLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func performTotalLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        for view in subviews {
            view.performTotalLayout()
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func addSubViewWithSameSize(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subview.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
    }
    
    func addSubViewToTop(subview: UIView, withHeight height: CGFloat) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: self.topAnchor),
            subview.widthAnchor.constraint(equalTo: self.widthAnchor),
            subview.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    func addSubView(subview: UIView, under underView: UIView? = nil, toTop: Bool = false, marginTop: CGFloat = 0, above aboveView: UIView? = nil, toBottom: Bool = false, marginBottom: CGFloat = 0, leftOfView leftView: UIView? = nil, toRightEdge: Bool = false, marginRight: CGFloat = 0, rightOfView rightView: UIView? = nil, toLeftEdge: Bool = false, marginLeft: CGFloat = 0, withHeight height: CGFloat? = nil, withWidth width: CGFloat? = nil, toCenterX: Bool = false, toCenterY: Bool = false) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        
        if toTop {
            NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: marginTop),
            ])
        }
        if let underView = underView {
            NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: underView.bottomAnchor, constant: marginBottom),
            ])
        }
        
        if toBottom {
            NSLayoutConstraint.activate([
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: marginBottom),
            ])
        }
        if let aboveView = aboveView {
            NSLayoutConstraint.activate([
            subview.bottomAnchor.constraint(equalTo: aboveView.topAnchor, constant: marginTop),
            ])
        }
        
        if toLeftEdge {
            NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: marginLeft),
            ])
        }
        if let rightView = rightView {
            NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: marginLeft),
            ])
        }
        
        if toRightEdge {
            NSLayoutConstraint.activate([
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: marginRight),
            ])
        }
        if let leftView = leftView {
            NSLayoutConstraint.activate([
            subview.trailingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: marginRight),
            ])
        }
        
        if let height = height {
            NSLayoutConstraint.activate([
            subview.heightAnchor.constraint(equalToConstant: height),
            ])
        }
        
        if let width = width {
            NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalToConstant: width),
            ])
        }
        
        if toCenterX {
            NSLayoutConstraint.activate([
                subview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        }
        
        if toCenterY {
            NSLayoutConstraint.activate([
                subview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        }
    }
    
    func addDropShadow() {
        self.layer.shadowOpacity = 0.23
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4.0

        let shadowRect: CGRect = self.bounds.inset(by: UIEdgeInsets(top: 0, left: -3, bottom: -3, right: -3))

        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 2 * self.layer.cornerRadius).cgPath
    }
    
    func addBorder(thick: Bool = false, colour: UIColor) {
        self.layer.borderWidth = thick ? 4 : 1
        self.layer.borderColor = colour.cgColor
    }
    
    func addBlurryBackground(withColour: UIColor) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.backgroundColor = withColour.withAlphaComponent(0.3)
        addSubViewWithSameSize(subview: blurredEffectView)
        
        for subview in self.subviews {
            if subview != blurredEffectView {
                self.bringSubviewToFront(subview)
            }
        }
    }
    
    func animateHidden(hidden: Bool, completionBlock: (() -> Void)? = nil) {
        self.alpha = hidden ? 1 : 0
        self.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.alpha = hidden ? 0 : 1
        } completion: { finished in
            if(finished) {
                if(hidden) {
                    self.isHidden = true
                }
                completionBlock?()
            }
        }

    }
    
    func setGradientBackgroundColour(topColour: UIColor, bottomColour: UIColor) {
        let kGradientSublayerName = "kGradientSublayerName"
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                if sublayer.name == kGradientSublayerName {
                    sublayer.removeFromSuperlayer()
                }
            }
        }
        let gl = CAGradientLayer()
        gl.name = kGradientSublayerName
        gl.colors = [topColour.cgColor, bottomColour.cgColor]
        gl.locations = [0.0, 1.0]
        
        gl.frame = self.bounds
        self.layer.insertSublayer(gl, at: 0)
    }
}

//
//  InternalNavBar.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import UIKit

class InternalNavBar: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

       initialize()
    }

}

//MARK: Initialization
extension InternalNavBar {
    func initialize() {
        self.backgroundColor = Theme.Colours.white.color
        
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        let margin: CGFloat = 4
        self.addSubView(subview: imageView, toTop: true, marginTop: self.safeAreaInsets.top + margin, toBottom: true, marginBottom: -margin, toLeftEdge: true, marginLeft: margin)
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 0
        
        let daycareButton = UIButton()
        daycareButton.configuration = config
        daycareButton.setImage(UIImage(systemName: "house.circle.fill"), for: .normal)
        self.addSubView(subview: daycareButton, toTop: true, marginTop: self.safeAreaInsets.top, toBottom: true, toRightEdge: true, marginRight: -margin)
        daycareButton.addConstraint(daycareButton.heightAnchor.constraint(equalTo: daycareButton.widthAnchor, multiplier: 1.0))
        
        let petButton = UIButton()
        petButton.setImage(UIImage(systemName: "pawprint.circle.fill"), for: .normal)
        petButton.configuration = config
        self.addSubView(subview: petButton, toTop: true, marginTop: self.safeAreaInsets.top, toBottom: true, leftOfView: daycareButton, marginRight: -margin, rightOfView: imageView, marginLeft: margin)
        petButton.addConstraint(petButton.heightAnchor.constraint(equalTo: petButton.widthAnchor, multiplier: 1.0))
        
        self.addBottomShadow()
    }
}

//
//  InternalNavBar.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import UIKit

protocol InternalNavBarDelegate {
    func internalNavBar(internalNavBar: InternalNavBar, shouldShowAlertController alertController: UIAlertController)
}

class InternalNavBar: UIView {

    private let daycareButton = UIButton()
    private let petButton = UIButton()
    
    var _delegate: InternalNavBarDelegate?
    
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
        
        daycareButton.configuration = config
        daycareButton.setImage(UIImage(systemName: "house.circle"), for: .normal)
        daycareButton.addTarget(self, action: #selector(daycareButton_didPress), for: .touchUpInside)
        self.addSubView(subview: daycareButton, toTop: true, marginTop: self.safeAreaInsets.top, toBottom: true, toRightEdge: true, marginRight: -margin)
        daycareButton.addConstraint(daycareButton.heightAnchor.constraint(equalTo: daycareButton.widthAnchor, multiplier: 1.0))
        
        petButton.setImage(UIImage(systemName: "pawprint.circle"), for: .normal)
        petButton.configuration = config
        petButton.addTarget(self, action: #selector(petButton_didPress), for: .touchUpInside)
        self.addSubView(subview: petButton, toTop: true, marginTop: self.safeAreaInsets.top, toBottom: true, leftOfView: daycareButton, marginRight: -margin, rightOfView: imageView, marginLeft: margin)
        petButton.addConstraint(petButton.heightAnchor.constraint(equalTo: petButton.widthAnchor, multiplier: 1.0))
        
        self.addBottomShadow()
        
        self.setupSubscriptions()
    }
    
    func setupSubscriptions() {
        SessionManager.current.subscribe(toObserserve: .daycare) {
            self.daycareButton.setImage(UIImage(systemName: SessionManager.current.daycare == nil ? "house.circle" : "house.circle.fill"), for: .normal)
        }
        
        SessionManager.current.subscribe(toObserserve: .pet) {
            self.petButton.setImage(UIImage(systemName: SessionManager.current.pet == nil ? "pawprint.circle" : "pawprint.circle.fill"), for: .normal)
        }
    }
}

//MARK: Button Handlers
@objc extension InternalNavBar {
    func daycareButton_didPress() {
        let alert = UIAlertController(title: StandardStrings.Navigation.FilterDaycareTitle.string, message: StandardStrings.Navigation.FilterDaycareMessage.string, preferredStyle: .actionSheet)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.daycareButton
        }
        
        alert.addAction(UIAlertAction(title: StandardStrings.Misc.None.string, style: .default, handler: { _ in
            SessionManager.current.daycare = nil
        }))
        
        if let profile = SessionManager.current.profile {
            for daycare in profile.daycares {
                alert.addAction(UIAlertAction(title: daycare.name, style: .default, handler: { _ in
                    SessionManager.current.daycare = daycare
                }))
            }
        }
        
        alert.addAction(UIAlertAction(title: StandardStrings.Misc.Cancel.string, style: .cancel))
        
        _delegate?.internalNavBar(internalNavBar: self, shouldShowAlertController: alert)
    }
    
    func petButton_didPress() {
        let alert = UIAlertController(title: StandardStrings.Navigation.FilterPetsTitle.string, message: StandardStrings.Navigation.FilterPetsMessage.string, preferredStyle: .actionSheet)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.daycareButton
        }
        
        alert.addAction(UIAlertAction(title: StandardStrings.Misc.None.string, style: .default, handler: { _ in
            SessionManager.current.pet = nil
        }))
        
        if let profile = SessionManager.current.profile {
            for pet in profile.pets {
                alert.addAction(UIAlertAction(title: pet.name, style: .default, handler: { _ in
                    SessionManager.current.pet = pet
                }))
            }
        }
        
        alert.addAction(UIAlertAction(title: StandardStrings.Misc.Cancel.string, style: .cancel))
        
        _delegate?.internalNavBar(internalNavBar: self, shouldShowAlertController: alert)
    }
}

//
//  JoinDaycareModelView.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import Foundation

class JoinDaycareModelView {
    var daycareService: DaycareService
    
    internal init(selectedPet: Pet?, daycareService: DaycareService) {
        self.selectedPet = selectedPet
        self.daycareService = daycareService
    }
    
    var selectedDaycare: Daycare? {
        didSet {
            self.tableViewReloadCompletionBlock?()
        }
    }
    var selectedPet: Pet?
    
    var daycares: [Daycare] = [] {
        didSet {
            self.tableViewReloadCompletionBlock?()
        }
    }
    
    var daycareData: [Daycare] {
        get {
            if let selectedDaycare = selectedDaycare {
                if daycares.contains(where: { $0.id == selectedDaycare.id }) {
                    return daycares
                } else {
                    var toReturn = daycares
                    toReturn.insert(selectedDaycare, at: 0)
                    return toReturn
                }
            } else {
                return daycares
            }
        }
    }
    
    var tableViewReloadCompletionBlock: (() -> Void)?
}

//MARK: Onboarding Component Conforming
extension JoinDaycareModelView {
    func onboardingComponentIsValid() -> Bool {
        guard selectedPet != nil else { return false }
        guard selectedDaycare != nil else { return false }
        
        return true
    }
}

//MARK: Search Bar Delegate
extension JoinDaycareModelView {
    func updateDataForSearchText(text: String?) {
        guard let text = text else { self.daycares = []; return }
        if text.count > 2 {
            daycareService.search(desc: text) { daycares, error in
                guard error == nil else { return }
                
                DispatchQueue.main.async {
                    self.daycares = daycares
                }
            }
        } else {
            self.daycares = []
        }
    }
}

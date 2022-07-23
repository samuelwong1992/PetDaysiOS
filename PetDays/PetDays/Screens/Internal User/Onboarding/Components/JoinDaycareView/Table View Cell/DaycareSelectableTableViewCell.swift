//
//  DaycareSelectableTableViewCell.swift
//  PetDays
//
//  Created by Samuel Wong on 23/7/2022.
//

import UIKit

class DaycareSelectableTableViewCell: UITableViewCell {

    static let kCellReuseIdentifier = "DaycareSelectableTableViewCell"
    
    var daycare: Daycare! {
        didSet {
            config.text = daycare.name
            config.secondaryText = daycare.address
            
            self.contentConfiguration = config
        }
    }
    
    var isCurrentDaycare: Bool! {
        didSet {
            config.image = isCurrentDaycare ? UIImage(systemName: "checkmark") : nil
            
            self.contentConfiguration = config
        }
    }
    
    lazy var config: UIListContentConfiguration = {
        return self.defaultContentConfiguration()
    }()
}

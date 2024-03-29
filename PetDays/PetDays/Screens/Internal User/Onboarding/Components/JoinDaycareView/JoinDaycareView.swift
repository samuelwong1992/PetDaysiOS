//
//  JoinDaycareView.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

class JoinDaycareView: UIView {
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var modelView: JoinDaycareModelView
    
    required init?(coder aDecoder: NSCoder) {
        self.modelView = JoinDaycareModelView(selectedPet: nil, daycareService: DaycareAPIService())
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    init(frame: CGRect, modelView: JoinDaycareModelView) {
        self.modelView = modelView
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        super.loadViewFromNib(StoryboardConstants.Nib.JoinDaycareView.identifier, forClass: JoinDaycareView.self)
        
        initialize()
    }
}

//MARK: Initialization
extension JoinDaycareView {
    func initialize() {
        searchView.delegate = self
        
        tableView.register(DaycareSelectableTableViewCell.self, forCellReuseIdentifier: DaycareSelectableTableViewCell.kCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        modelView.tableViewReloadCompletionBlock = {() -> Void in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: Onboarding Component Conforming
extension JoinDaycareView: OnboardingComponent {
    func onboardingComponentIsValid() -> Bool {
        return modelView.onboardingComponentIsValid()
    }
}

//MARK: Search Bar Delegate
extension JoinDaycareView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        modelView.updateDataForSearchText(text: searchBar.text)
    }
}

//MARK: Table View Delegate and Data Source
extension JoinDaycareView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelView.daycareData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DaycareSelectableTableViewCell.kCellReuseIdentifier) as! DaycareSelectableTableViewCell
        
        let daycare = modelView.daycareData[indexPath.row]
        cell.daycare = daycare
        if let selectedDaycare = modelView.selectedDaycare {
            cell.isCurrentDaycare = daycare.id == selectedDaycare.id
        } else {
            cell.isCurrentDaycare = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modelView.selectedDaycare = modelView.daycareData[indexPath.row]
    }
}

//
//  JoinDaycareView.swift
//  PetDays
//
//  Created by Samuel Wong on 21/6/2022.
//

import UIKit

class JoinDaycareView: UIView {
    private static let kCellReuseIdentifier = "JoinDaycareViewCell"
    
    var selectedDaycare: Daycare?
    var selectedPet: Pet?
    
    var daycareService: DaycareService
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var daycares: [Daycare] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var daycareData: [Daycare] {
        get {
            if let selectedDaycare = selectedDaycare {
                if daycares.contains(where: { $0 == selectedDaycare }) {
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
    
    required init?(coder aDecoder: NSCoder) {
        self.daycareService = DaycareAPIService()
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    init(frame: CGRect, daycareService: DaycareService) {
        self.daycareService = daycareService
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: JoinDaycareView.kCellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: Onboarding Component Conforming
extension JoinDaycareView: OnboardingComponent {
    func onboardingComponentIsValid() -> Bool {
        guard selectedPet != nil else { return false }
        guard selectedDaycare != nil else { return false }
        
        return true
    }
}

//MARK: Search Bar Delegate
extension JoinDaycareView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { self.daycares = []; return }
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

//MARK: Table View Delegate and Data Source
extension JoinDaycareView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daycareData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JoinDaycareView.kCellReuseIdentifier)!
        
        let daycare = self.daycareData[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = daycare.name
        config.secondaryText = daycare.address
        if let selectedDaycare = self.selectedDaycare {
            config.image = daycare == selectedDaycare ? UIImage(systemName: "checkmark") : nil
        } else {
            config.image = nil
        }
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDaycare = self.daycareData[indexPath.row]
        self.tableView.reloadData()
    }
}

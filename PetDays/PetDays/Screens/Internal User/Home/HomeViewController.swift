//
//  HomeViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 9/6/2022.
//

import UIKit

class HomeViewController: UIViewController, ScreenComponent {
    var screen: HomeScreen!
    
    static var viewController: HomeViewController? {
        return StoryboardConstants.Storyboards.Internal.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.HomeViewController.identifier) as? HomeViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        screen.interactor.viewDidLoad()
    }
}

//MARK: Initialization
extension HomeViewController {
    func initialize() {
        tableView.register(PostTableViewCell.kNib, forCellReuseIdentifier: PostTableViewCell.kReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: Table View Delegate and Data Source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SessionManager.current.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.kReuseIdentifier) as! PostTableViewCell
        
        cell.viewModel = PostTableViewCellModelView(post: SessionManager.current.posts[indexPath.row])
        
        cell.containerView.isHidden = false
        if cell.viewModel.postPhotos.count > 0 {
            let vc = PostsPageViewController()
            vc.postPhotos = cell.viewModel.postPhotos
            self.addChild(vc)
            cell.containerView.addSubViewWithSameSize(subview: vc.view)
        } else {
            cell.containerView.isHidden = true
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

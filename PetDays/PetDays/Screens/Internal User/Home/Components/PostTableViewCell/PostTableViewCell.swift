//
//  PostTableViewCell.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let kNib = UINib(nibName: StoryboardConstants.Nib.PostTableViewCell.identifier, bundle: nil)
    static let kReuseIdentifier = StoryboardConstants.Nib.PostTableViewCell.identifier
    
    @IBOutlet weak var daycareImageView: UIImageView!
    @IBOutlet weak var daycareLabel: InputLabel!
    
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeLabel: DetailLabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var postLabel: UILabel!
    
    var viewModel: PostTableViewCellModelView! {
        didSet {
            initialize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        initialize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

extension PostTableViewCell {
    func setupView() {
        self.selectionStyle = .none
        
        daycareImageView.contentMode = .scaleAspectFit
        daycareImageView.setRoundedCorners()
        daycareImageView.addBorder(colour: Theme.Colours.primary.color)
        
        employeeImageView.contentMode = .scaleAspectFit
        employeeImageView.setRoundedCorners()
        employeeImageView.addBorder(colour: Theme.Colours.primary.color)
    }
    
    func initialize() {
        if let vm = viewModel {
            daycareLabel.text = vm.titleText
            employeeLabel.text = vm.subtitleText
            postLabel.text = vm.mainText
            
            vm.getPrimaryImage { [weak self] image in
                DispatchQueue.main.async {
                    self?.daycareImageView.image = image
                }
            }
            
            vm.getSecondaryImage { [weak self] image in
                DispatchQueue.main.async {
                    self?.employeeImageView.image = image
                }
            }
            
            containerView.isHidden = false
            if vm.postPhotos.count > 0 {
                let vc = PostsPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
                vc.postPhotos = vm.postPhotos
                vm.pagerParent.addChild(vc)
                containerView.addSubViewWithSameSize(subview: vc.view)
            } else {
                containerView.isHidden = true
            }
        }
    }
}

//
//  PostsPageViewController.swift
//  PetDays
//
//  Created by Samuel Wong on 22/6/2022.
//

import UIKit

class PostsPageViewController: UIPageViewController {
    
    var postPhotos: [PostPhoto] = []
    var _viewControllers: [UIViewController] = []
    
    var index = 0 {
        didSet {
            if index < _viewControllers.count {
                self.setViewControllers([_viewControllers[index]], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension PostsPageViewController {
    func initialize() {
        _viewControllers = []
                
        for postPhoto in postPhotos {
            _viewControllers.append(ImageViewController(postPhoto: postPhoto))
        }
        
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([_viewControllers.first!], direction: .forward, animated: false, completion: nil)
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [PostsPageViewController.self])
        appearance.pageIndicatorTintColor = Theme.Colours.primary.color.withAlphaComponent(0.4)
        appearance.currentPageIndicatorTintColor = Theme.Colours.primary.color
    }
}

extension PostsPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = _viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return _viewControllers.last }
        guard _viewControllers.count > previousIndex else { return nil }

        return _viewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = _viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < _viewControllers.count else { return _viewControllers.first }
        guard _viewControllers.count > nextIndex else { return nil }

        return _viewControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return _viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first else { return 0 }
        guard let firstVCIndex = _viewControllers.firstIndex(of: firstVC) else { return 0 }

        return firstVCIndex
    }
}


class ImageViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let toReturn = UIImageView(frame: self.view.frame)
        
        toReturn.contentMode = .scaleAspectFit
        
        return toReturn
    }()
    
    var postPhoto: PostPhoto
    
    init(postPhoto: PostPhoto) {
        self.postPhoto = postPhoto
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubViewWithSameSize(subview: imageView)
                
        APIManager.current.fetchImageAtUrl(url: postPhoto.photoUrl) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}

//
//  IntroViewController.swift
//  POE
//
//  Created by Benjamin Erhart on 22.03.17.
//  Copyright © 2017 Guardian Project. All rights reserved.
//

import UIKit

public class IntroViewController: XibViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?

    @IBOutlet weak var pageControl: UIPageControl!

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Configure the page view controller and add it as a child view controller.
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal, options: nil)
        pageViewController!.delegate = self

        let startingViewController = modelController.viewControllerAtIndex(0)!
        pageViewController!.setViewControllers([startingViewController], direction: .forward,
                                               animated: false, completion: {done in })

        pageViewController!.dataSource = modelController

        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)

        // Set the page view controller's bounds using an inset rect so that self's view is visible
        // around the edges of the pages.
        pageViewController!.view.frame = self.view.bounds
            .insetBy(dx: 0, dy: 25).offsetBy(dx: 0, dy: -25)

        pageViewController!.didMove(toParentViewController: self)
    }

    var modelController: ModelController {
        // Return the model controller object, creating it if necessary.
        // In more complex implementations, the model controller may be passed to the view controller.
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil

    @IBAction func nextPage() {
        jumpToView(pageControl.currentPage + 1)
    }
    
    @IBAction func pageChanged() {
        jumpToView(pageControl.currentPage)
    }

    // MARK: - UIPageViewController delegate methods

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {

        pageControl.currentPage = modelController.indexOfViewController(pendingViewControllers[0])
    }


    public func pageViewController(_ pageViewController: UIPageViewController,
                                   spineLocationFor orientation: UIInterfaceOrientation)
        -> UIPageViewControllerSpineLocation {

        let currentViewController = self.pageViewController!.viewControllers![0]
        self.pageViewController!.setViewControllers([currentViewController], direction: .forward,
                                                    animated: true, completion: {done in })

        self.pageViewController!.isDoubleSided = false
        return .min
    }

    // MARK: - private methods

    /**
        Jump to a ViewController of a given index.
     
        Fetches the proper ViewController, calculates the animation direction.
     */
    private func jumpToView(_ index: Int) {
        var current :Int = 0

        if let viewController = pageViewController?.viewControllers?[0] {
            current = modelController.indexOfViewController(viewController)

            if current == NSNotFound {
                current = 0
            }
        }

        if let next = modelController.viewControllerAtIndex(index) {
            pageViewController(pageViewController!, willTransitionTo: [next])

            let direction = current < index
                ? UIPageViewControllerNavigationDirection.forward
                : UIPageViewControllerNavigationDirection.reverse

            pageViewController?.setViewControllers([next],
                                                   direction: direction,
                                                   animated: true,
                                                   completion: nil)
        }
    }
}

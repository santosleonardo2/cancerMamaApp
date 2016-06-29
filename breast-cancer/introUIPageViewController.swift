//
//  introUIPageViewController.swift
//  breast-cancer
//
//  Created by leonardo on 6/29/16.
//  Copyright © 2016 LIKA. All rights reserved.
//

import UIKit

class introUIPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let page1 : UIViewController = myStoryboard.instantiateViewControllerWithIdentifier("introView1")
        let page2 : UIViewController = myStoryboard.instantiateViewControllerWithIdentifier("introView2")
        let page3 : UIViewController = myStoryboard.instantiateViewControllerWithIdentifier("introView3")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.indexOf(viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

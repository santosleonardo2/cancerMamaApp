//
//  AppDelegate.swift
//  Teste
//
//  Created by leonardo on 1/23/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import UIKit
import ResearchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabBarController: UITabBarController {
        return window!.rootViewController as! UITabBarController
    }
    
    var atividadesTableViewController: AtividadesTableViewController {
        let navigationController = tabBarController.viewControllers!.first as! UINavigationController
        
        return navigationController.visibleViewController as! AtividadesTableViewController
    }
    
    var resultViewController: ResultViewController? {
        let navigationController = tabBarController.viewControllers![4] as! UINavigationController
        
        // Find the `ResultViewController` (if any) that's a view controller in the navigation controller.
        return navigationController.viewControllers.filter { $0 is ResultViewController }.first as? ResultViewController
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Defining appearance to the action bar
        UINavigationBar.appearance().barTintColor = UIColor(red: 239.0/255.0, green: 162.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().tintColor = UIColor.blackColor()
        UITabBar.appearance().selectedImageTintColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        
        
        // When a task result has been finished, update the result view controller's task result.
        atividadesTableViewController.taskResultFinishedCompletionHandler = { [unowned self] taskResult in
            /*
            If we're displaying a new result, make sure the result view controller's
            navigation controller is at the root.
            */
            if let navigationController = self.resultViewController?.navigationController {
                navigationController.popToRootViewControllerAnimated(false)
            }
            
            // Set the result so we can display it.
            self.resultViewController?.result = taskResult
        }

        return true
    }

    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


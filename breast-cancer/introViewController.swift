//
//  introViewController.swift
//  breast-cancer
//
//  Created by leonardo on 6/29/16.
//  Copyright © 2016 LIKA. All rights reserved.
//

import UIKit

class introViewController : UIViewController {
    
    @IBOutlet weak var registerUserButton: UIButton!
    @IBOutlet weak var loginUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*registerUserButton.layer.borderWidth = 1.0
        registerUserButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        loginUserButton.layer.borderWidth = 1.0
        loginUserButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        */
    }
    
    @IBAction func registerUserButtonPressed(sender: AnyObject) {
        let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let nextView : UIViewController = myStoryboard.instantiateViewControllerWithIdentifier("RegisterView")
        presentViewController(nextView, animated: true, completion: nil)
    }
    
    @IBAction func loginUserButtonPressed(sender: AnyObject) {
        let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let nextView : UIViewController = myStoryboard.instantiateViewControllerWithIdentifier("LoginView")
        presentViewController(nextView, animated: true, completion: nil)
    }
}

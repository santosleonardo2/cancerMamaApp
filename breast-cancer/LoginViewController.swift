//
//  LoginViewController.swift
//  breast-cancer
//
//  Created by leonardo on 6/15/16.
//  Copyright © 2016 LIKA. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LoginButtonPressed(sender: AnyObject) {
        if(true)
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let nextView : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("menuPrincipal")
            presentViewController(nextView, animated: true, completion: nil)
        }
    }
}

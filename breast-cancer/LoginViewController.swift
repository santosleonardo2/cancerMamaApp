//
//  LoginViewController.swift
//  breast-cancer
//
//  Created by leonardo on 6/15/16.
//  Copyright © 2016 LIKA. All rights reserved.
//

import UIKit

@IBDesignable
class LoginViewController : UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        /*loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        */
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

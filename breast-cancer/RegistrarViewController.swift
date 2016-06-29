//
//  RegistrarViewController.swift
//  breast-cancer
//
//  Created by leonardo on 6/15/16.
//  Copyright © 2016 LIKA. All rights reserved.
//

import UIKit
import ResearchKit

class RegistrarViewController : UIViewController{

    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*registerButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        cancelButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = UIColor(red: 229.0/255.0, green: 62.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        */
    }
    
    @IBAction func RegistrarButtonPressed(sender: AnyObject) {
        if (true) {
            let task = Task.Consent.representedTask
            let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
            taskViewController.delegate = self
            // Assign a directory to store `taskViewController` output.
            taskViewController.outputDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!

            presentViewController(taskViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func CancelarButtonPressed(sender: AnyObject) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let mainView : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
        presentViewController(mainView, animated: true, completion: nil)
    }
}

extension RegistrarViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result (= ORKTaskResult)
        /* For survey question steps, the answers collected are reported as
        * ORKQuestionResult objects, which are children of ORKStepResult.
        */
        
        print("Results of the Task")
        switch(reason){
        case .Completed:
            let taskResults : ORKTaskResult = taskViewController.result
            //print("\(taskResults.results)") //It will print ALL variables on the result
            
            //Displaying some kinds of results on prompt screen
            let results = taskResults.results as! [ORKStepResult]
            for thisStepResult: ORKStepResult in results
            {
                if let _ = thisStepResult.results as? [ORKConsentSignatureResult]
                {
                    // CREATING .PDF WITH DOCUMENT CONSENT
                    print("Initializing .pdf consent document creation")
                    let signatureResult : ORKConsentSignatureResult = taskResults.stepResultForStepIdentifier("ConsentReviewStep")?.firstResult as! ORKConsentSignatureResult
                    let document = ConsentDocument.copy() as! ORKConsentDocument
                    signatureResult.applyToDocument(document)
                    document.makePDFWithCompletionHandler({ (pdfData: NSData?, error: NSError?) -> Void in
                        
                        var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as NSURL!
                        docURL = docURL?.URLByAppendingPathComponent( "Consentimento.pdf")
                        
                        print("\(docURL)")
                        //write your file to the disk.
                        pdfData?.writeToURL(docURL!, atomically: true)
                        //now you can see that pdf in your applications directory
                    })
                }
            }
            break
            
        case .Saved:
            print("Results Saved!")
            break;
            
        case .Discarded, .Failed:
            print("Results Discarded OR Failed!")
            break
        }
        
        //Go back to main viewController
        if(reason == .Completed) {
            //Moving to app main windown
            taskViewController.dismissViewControllerAnimated(true, completion: nil)
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let mainView : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("menuPrincipal")
            presentViewController(mainView, animated: true, completion: nil)
        }
        else {
            taskViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
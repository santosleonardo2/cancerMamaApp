//
//  AtividadesTableViewController.swift
//  Teste
//
//  Created by leonardo on 2/3/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import UIKit
import ResearchKit

@IBDesignable
class AtividadesTableViewController: UITableViewController {
    
    var atividadesTopicos = [String]()
    var tasks = Task.allCases
    var backgroundColorCell : Bool = true
    
    @IBOutlet weak var dateLabel: UILabel!
    let currentDate = NSDate()
    let currentDateFormatter = NSDateFormatter()
    
    var taskResultFinishedCompletionHandler: (ORKResult -> Void)?
    
    enum TableViewCellIdentifier : String {
        case Default = "Default"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For more details on how to set date: http://www.appcoda.com/nsdate/
        currentDateFormatter.locale = NSLocale(localeIdentifier: "por_BR")
        currentDateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateLabel.text = currentDateFormatter.stringFromDate(currentDate)
        
        atividadesTopicos = ["Consentimentos",
                             "Questionário Diário",
                             "Questionário Semanal",
                             "Questionário Mensal",
                             "Diário Pessoal"]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("atividadesCell", forIndexPath: indexPath)
        
        let taskListRow = tasks[indexPath.row]
        cell.textLabel!.text = "\(taskListRow)"
        cell.textLabel!.font = UIFont.systemFontOfSize(17.0)
        cell.textLabel!.textColor = UIColor.darkGrayColor()
        if(backgroundColorCell) //Toggle background color
        {
            cell.backgroundColor = UIColor(red: 252.0/255.0, green: 235.0/255, blue: 243.0/255.0, alpha: 1.0)
            backgroundColorCell = false
        }
        else
        {
            backgroundColorCell = true
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Present the TaskViewController that the user asked for.
        let taskListRow = tasks[indexPath.row]
        
        // Create a task from the `TaskListRow` to present in the `ORKTaskViewController`.
        let task = taskListRow.representedTask
        
        /*
        Passing `nil` for the `taskRunUUID` lets the task view controller
        generate an identifier for this run of the task.
        */
        let taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
        
        // Make sure we receive events from `taskViewController`.
        taskViewController.delegate = self
        
        // Assign a directory to store `taskViewController` output.
        taskViewController.outputDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        
        /*
        We present the task directly, but it is also possible to use segues.
        The task property of the task view controller can be set any time before
        the task view controller is presented.
        */
        presentViewController(taskViewController, animated: true, completion: nil)
    }
}

extension AtividadesTableViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result (= ORKTaskResult)
        /* For survey question steps, the answers collected are reported as
         * ORKQuestionResult objects, which are children of ORKStepResult.
         */
        
        print("Results of the Task")
        
        //Displaying results in a table
        taskResultFinishedCompletionHandler!(taskViewController.result)
        
        switch(reason){
        case .Completed:
            let taskResults : ORKTaskResult = taskViewController.result
            //print("\(taskResults.results)") //It will print ALL variables on the result
            
            //Displaying some kinds of results on prompt screen
            let results = taskResults.results as! [ORKStepResult]
            for thisStepResult: ORKStepResult in results
            {
                if let answer = thisStepResult.results as? [ORKQuestionResult]
                {
                    if let s = answer.first as? ORKBooleanQuestionResult
                    {
                        print("Boolean Format --> Identifier: \(s.identifier), Anwer: \(s.booleanAnswer))")
                    }
                    else if let a = answer.first as? ORKDateQuestionResult
                    {
                        print("Date Format --> Identifier: \(a.identifier), Calendar: \(a.calendar), Time Zone: \(a.timeZone), Answer: \(a.dateAnswer)")
                    }
                    else if let a = answer.first as? ORKTextQuestionResult
                    {
                        print("Text Format --> Identifier: \(a.identifier), Answer: \(a.textAnswer)")
                    }
                    else if let a = answer.first as? ORKScaleQuestionResult
                    {
                        print("Scale Format --> Identifier: \(a.identifier), Answer: \(a.scaleAnswer)")
                    }
                    else if let a = answer.first as? ORKChoiceQuestionResult
                    {
                        print("Choice Format --> Identifier: \(a.identifier), Answer: \(a.choiceAnswers)")
                    }
                }
                else if let _ = thisStepResult.results as? [ORKConsentSignatureResult]
                {
                    // CREATING .PDF WITH DOCUMENT CONSENT
                    print("Initializing .pdf consent document creation")
                    let signatureResult : ORKConsentSignatureResult = taskResults.stepResultForStepIdentifier("ConsentReviewStep")?.firstResult as! ORKConsentSignatureResult
                    let document = ConsentDocument.copy() as! ORKConsentDocument
                    signatureResult.applyToDocument(document)
                    print("\(signatureResult)")
                    document.makePDFWithCompletionHandler({ (pdfData: NSData?, error: NSError?) -> Void in
                        
                        print("It is here!!!!")
                        var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as! NSURL!
                        docURL = docURL?.URLByAppendingPathComponent( "Consentimento.pdf")
                        
                        print("\(docURL)")
                        //write your file to the disk.
                        pdfData?.writeToURL(docURL!, atomically: true)
                        //now you can see that pdf in your applications directory
                    })

                }
            }
            break
            
        case .Saved, .Discarded, .Failed:
            print("Results Saved, Discarded OR Failed!")
            break
        }
        
        //Go back to main viewController
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}


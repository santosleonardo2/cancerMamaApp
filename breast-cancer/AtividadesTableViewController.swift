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
        
        atividadesTopicos = ["Questionário Diário",
                             "Questionário Semanal",
                             "Questionário Mensal",
                             "Diário Pessoal",
                             "Resveratrol",
                             "Navigation Task Test"]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : AtividadesCellLayout = self.tableView.dequeueReusableCellWithIdentifier("atividadesCell", forIndexPath: indexPath) as! AtividadesCellLayout
        
        let taskListRow = tasks[indexPath.row]
        cell.atividadesCellImage.image = UIImage(named: "atividadeNaoFinalizada")
        cell.atividadesCellLabel.text = "\(taskListRow)"
        if((indexPath.row%2) == 0) //Toggle background color
        {
            cell.backgroundColor = UIColor(red: 252.0/255.0, green: 235.0/255, blue: 243.0/255.0, alpha: 1.0)
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
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
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}


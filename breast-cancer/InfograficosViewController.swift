//
//  infograficosViewController.swift
//  Teste
//
//  Created by Laboratório de Informática em saúde on 27/01/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import UIKit
import ResearchKit

class InfograficosViewController: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    let currentDate = NSDate()
    let currentDateFormatter = NSDateFormatter()
    
    let pieChartDataSource = PieChartDataSource()
    let pieChartIdentifier = "PieChartCell"
    var pieChartTableViewCell: PieChartTableViewCell!
    
    var chartTableViewCells: [UITableViewCell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //For more details on how to set date: http://www.appcoda.com/nsdate/
        currentDateFormatter.locale = NSLocale(localeIdentifier: "por_BR")
        currentDateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateLabel.text = currentDateFormatter.stringFromDate(currentDate)
        
        // ORKPieChartView
        pieChartTableViewCell = tableView.dequeueReusableCellWithIdentifier(pieChartIdentifier) as! PieChartTableViewCell
        let pieChartView = pieChartTableViewCell.pieChartView
        pieChartView.dataSource = pieChartDataSource
        // Optional custom configuration
        pieChartView.title = "Atividades"
        pieChartView.text = "Hoje"
        pieChartView.lineWidth = 14
        
        chartTableViewCells = [pieChartTableViewCell]
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("MEMORY WARNING!!!")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartTableViewCells.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = chartTableViewCells[indexPath.row];
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pieChartTableViewCell.pieChartView.animateWithDuration(0.5)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}


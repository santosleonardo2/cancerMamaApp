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

    let lineGraphChartDataSource = LineGraphDataSource()
    let lineGraphChartIdentifier = "LineGraphChartCell"
    var lineGraphChartTableViewCell: LineGraphChartTableViewCell!

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
        
        // ORKLineGraphChartView
        lineGraphChartTableViewCell = tableView.dequeueReusableCellWithIdentifier(lineGraphChartIdentifier) as! LineGraphChartTableViewCell
        let lineGraphChartView = lineGraphChartTableViewCell.graphView as! ORKLineGraphChartView
        lineGraphChartView.dataSource = lineGraphChartDataSource
        lineGraphChartView.tintColor = UIColor(red: 239/255, green: 162/255, blue: 199/255, alpha: 1)
        // Optional custom configuration
        lineGraphChartView.showsHorizontalReferenceLines = true
        lineGraphChartView.showsVerticalReferenceLines = true
        
        chartTableViewCells = [pieChartTableViewCell, lineGraphChartTableViewCell]
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
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
        lineGraphChartTableViewCell.graphView.animateWithDuration(0.5)
    }
}


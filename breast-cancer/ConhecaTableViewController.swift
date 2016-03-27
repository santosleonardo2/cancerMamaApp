//
//  ConhecaTableViewController.swift
//  Teste
//
//  Created by Laboratório de Informática em saúde on 27/01/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import UIKit
import ResearchKit

class ConhecaTableViewController: UITableViewController {
    
    var atividades = [String]()
    var backgroundColorCell: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.atividades = ["Sobre o Estudo",
                            "Como Funciona",
                            "Pesquisadores",
                            "Sobre o Câncer",
                            "Compartilhe o App",
                            "Vida Pós Tratamento"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.atividades.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CellConheca", forIndexPath: indexPath) as UITableViewCell
        var atividades : String
        atividades = self.atividades[indexPath.row]
        cell.textLabel?.text = atividades
        cell.textLabel!.font = UIFont.systemFontOfSize(17.0)
        cell .textLabel!.textColor = UIColor.darkGrayColor()
        if (backgroundColorCell)
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

   
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

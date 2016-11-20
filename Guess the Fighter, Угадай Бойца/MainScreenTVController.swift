//
//  MainScreenTVController.swift
//  Guess the Fighter, Угадай Бойца
//
//  Created by Artem on 11/17/16.
//  Copyright © 2016 piqapp. All rights reserved.
//

import UIKit

class MainScreenTVController: UITableViewController {

    @IBOutlet weak var firstCell: UIView!
    
    var gradient: CAGradientLayer!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let gradientColors = [UIColor.magentaColor().CGColor, UIColor.blueColor().CGColor, UIColor.whiteColor().CGColor]
        let startPoint = CGPoint(x: 0.0, y: 0.0)
        let endPoint = CGPoint(x: 1.0, y: 0.0)
        let locations = [NSNumber(double: 0.0), NSNumber(double: 0.2), NSNumber(double: 0.4)]
        self.gradient = CAGradientLayer()
        
        setupGradient(firstCell.layer, frame: firstCell.bounds, gradient: self.gradient, colors: gradientColors, locations: locations, startPoint: startPoint, endPoint: endPoint, zPosition: -100)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.firstCell.layer.addSublayer(gradient)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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

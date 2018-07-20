//
//  MenuOwnerController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 19/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class MenuOwnerController: UITableViewController {

    var sections = [Int]()
    
    func numberOfTables() {
        sections = []
        for order in orders{
            if sections.contains(order.table){
            }else{
                sections.append(order.table)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfTables()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       // var sections: [Int] = []
//        sections = []
        
//        for order in orders{
//            if sections.contains(order.table){
//            }else{
//                sections.append(order.table)
//            }
//        }
        numberOfTables()
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //var sections: [Int] = []
//        sections = []
//        for order in orders{
//            if sections.contains(order.table){
//            }else{
//                sections.append(order.table)
//            }
//    }
        numberOfTables()
        let title = "Table: \(sections[section].description)"
        return title
}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var t = sections[section]
        var o = orders.filter() {
            $0.table == t
        }
        return o.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownerCell", for: indexPath)
        var t = sections[indexPath.section]
        var o = orders.filter() {
            $0.table == t
        }
        cell.imageView?.image = o[indexPath.row].dish.photo
        cell.detailTextLabel?.text = String(o[indexPath.row].quantity)
        cell.textLabel?.text = o[indexPath.row].dish.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuCustomer"{
            var t = sections[(tableView.indexPathForSelectedRow?.section)!]
            var o = orders.filter() {
                $0.table == t
            }
            let currentidx = tableView.indexPathForSelectedRow?.row
            let vc = segue.destination as! OrderDetailOwnerController
            vc.orderDetail = o[currentidx!].dish
            vc.quantity = o[currentidx!].quantity
            vc.table = o[currentidx!].table
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

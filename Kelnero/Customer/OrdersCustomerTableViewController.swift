//
//  OrdersCustomerTableViewController.swift
//  Kelnero
//
//  Created by Monaco Simone on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrdersCustomerTableViewController: UITableViewController {
    
    
    var orders = [OrderRow]()
    let restaurant = Restaurant(ownerIcloudId: "_33caratteri", name: "Da Mario", address: "Via Mario Rossi")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ordine1 = OrderRow(restaurant: restaurant, table: 2, dish: pizza, quantity: 2, state: 3)
        orders.append(ordine1)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath)
        
        cell.imageView?.image = orders[indexPath.row].dish.photo
        cell.detailTextLabel?.text = String(orders[indexPath.row].quantity)
        cell.textLabel?.text = orders[indexPath.row].dish.name
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showOrder"?:
            let currentidx = tableView.indexPathForSelectedRow?.row
            let order = segue.destination as! OrderCustomerDetail
            order.order = orders[currentidx!]
        default:
            preconditionFailure("Invalid segue identifier.")
        }
        
        
    }
    
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


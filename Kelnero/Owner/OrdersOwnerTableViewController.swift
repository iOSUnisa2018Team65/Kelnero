//
//  OrdersOwnerTableViewController.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 19/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrdersOwnerTableViewController: UITableViewController {

    var restaurantId = "46da4a3ab2106811eecd8e73ea204468"
    var orders = [[OrderRow]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        OrderRowModel.getAllOrderRows(restaurantId: restaurantId) {
            (allOrders, error) in
            if let e = error {
                print(e)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Failed to load orders", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            else {
                self.orders = allOrders
                print(self.orders)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        tableView.register(OrdersOwnerTableViewCell.self, forCellReuseIdentifier: "orderOwnerCellReuseIdentifier")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(orders)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderOwnerCellReuseIdentifier", for: indexPath) as! OrdersOwnerTableViewCell

        // Configure the cell...
        var orderGroup = orders[indexPath.row]
        cell.tableLabel.text = orderGroup[0].table.description
        
        var totalDishes = 0
        var doneDishes = 0
        orderGroup.forEach() {
            orderLine in
            // * 2 because we consider preparing and delivering phases
            totalDishes = totalDishes + orderLine.quantity * 2
            if orderLine.state == 2 || orderLine.state == 3 {
                doneDishes = doneDishes + orderLine.quantity
            }
         }
        var progress = doneDishes / totalDishes * 100
        cell.progressBar.progress = Float(progress)
        
        return cell
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

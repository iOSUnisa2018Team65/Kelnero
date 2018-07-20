//
//  OrdersCustomerTableViewController.swift
//  Kelnero
//
//  Created by Monaco Simone on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit


let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

public extension UIView {
    public func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - width / 2,y: bounds.midY - width / 2, width: width, height: width)).cgPath
        self.layer.mask = mask
    }
}
    
class OrdersCustomerTableViewController: UITableViewController {
    
    var o: [OrderRow]?
    
    func filterRows() {
        o = orders.filter() {
            $0.table == 2
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        orders = []
        
        activityIndicator.startAnimating()
        tableView.separatorStyle = .none

            DispatchQueue.main.async {
                Thread.sleep(forTimeInterval: 3)

                    self.tableView.separatorStyle = .singleLine
                    self.tableView.reloadData()
                
       }
        
        
        orders = OrderRowModel.getAllOrders(restaurantId: "46da4a3ab2106811eecd8e73ea204468")
   
        
        
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        view.bringSubview(toFront: activityIndicator)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isEditing = false
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterRows()
        return o!.count
    }
    

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath)
        
        filterRows()
       
        cell.detailTextLabel?.text = String(o![indexPath.row].quantity)
        cell.textLabel?.text = o![indexPath.row].dish.name
        
        let image: UIImage = o![indexPath.row].dish.photo
        cell.imageView?.image = image
        
        /* makes the image round
        cell.imageView?.layer.cornerRadius = (cell.imageView?.bounds.height)! / 2
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .scaleAspectFill
         */
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            orders.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showOrder"?:
            let currentidx = tableView.indexPathForSelectedRow?.row
            let order = segue.destination as! OrderCustomerDetail
            filterRows()
            order.order = o?[currentidx!]
            order.orderIdx = currentidx
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


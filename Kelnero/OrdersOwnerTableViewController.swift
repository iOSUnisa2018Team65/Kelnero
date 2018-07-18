//
//  MenuOwnerTableViewController.swift
//  Kelnero
//
//  Created by Monaco Simone on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrdersOwnerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "editDish"?:
            break
        default:
            preconditionFailure("Identificatore segue non valido.")
        }
        
        if segue.identifier == "editDish" {
            
            // Figure out which row was just tapped
//            if let row = tableView.indexPathForSelectedRow?.row {
            
                // Get the item associated with this row and pass it along
//                let item = itemStore.allItems[row]
//                let detailViewController = segue.destination as! DetailViewController
//                detailViewController.item = item
//                detailViewController.imageStore = imageStore
//            }
        }
    }
    
//    GESTIONE MODIFICA TABELLA
    
    @IBAction func newItem(_ sender: Any) {
        // Create a new Item and add it to the store
//        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
//        if let index = itemStore.allItems.index(of: newItem) {
//            let indexPath = IndexPath(row: index, section: 0)
//
//            // Insert this new row into the table.
//            tableView.insertRows(at: [indexPath], with: .automatic)
//        }
    }
    
    //    override func tableView(_ tableView: UITableView,
//                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Create an instance of UITableViewCell, with default appearance
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
//                                                 for: indexPath) as! ItemCell
//
//        // Set the text on the cell with the description of the item
//        // that is at the nth index of items, where n = row this cell
//        // will appear in on the tableview
//        let item = itemStore.allItems[indexPath.row]
//
//        cell.nameLabel.text = item.name
//        cell.serialNumberLabel.text = item.serialNumber
//        cell.valueLabel.text = "$\(item.valueInDollars)"
//        let img = imageStore.image(forKey: item.itemKey)
//        cell.thumb.image = img
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Aggiorna l'ordine
//        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
//                Se viene ricevuto il comando di eliminazione...
            if editingStyle == .delete {
//            let item = itemStore.allItems[indexPath.row]
            
            
//            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                // Rimuovi l'oggetto dall'array oggetti
//                                                self.itemStore.removeItem(item)
                                                
                                                // Rimuovi l'immagine
//                                                self.imageStore.deleteImage(forKey: item.itemKey)
                                                
                                                // Rimuovi la cella dalla tabella con un'animazione
                                                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
//    NUMERO OGGETTI
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemStore.allItems.count
//    }

}

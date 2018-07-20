//
//  OrderCustomerDetail.swift
//  Kelnero
//
//  Created by Panariello Aniello on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrderCustomerDetail: UIViewController {
    
    var order: OrderRow?
    var orderIdx: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDish: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
        order?.quantity = Int(quantityLabel.text!)!

    }
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func deleteDishFromOrder(_ sender: Any) {
        //orders.remove(at: orderIdx!)
        //da implementare icloud
        OrderRowModel.delete(orderRow: order!) {
            error in
            if let e = error {
                print(e)
                let alert = UIAlertController(title: "Cannot delete order", message: "An error has occurred", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) {
                    (action) in
                    self.navigationController?.popViewController(animated: true)
                    })
                self.present(alert, animated: true)
            }
            else {
                print("OK")
                let alert = UIAlertController(title: "Deleted", message: "Dish removed from order", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) {
                    (action) in
                    self.navigationController?.popViewController(animated: true)
                    })
                    self.present(alert, animated: true)
            }
        }
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = order?.dish.name
        imageDish.image = order?.dish.photo
        descriptionLabel.text = order?.dish.descr
        quantityLabel.text = order?.quantity.description
        stepper.autorepeat = true
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.value = Double((order?.quantity)!)
        switch order?.state{
        case 1:
            statusLabel.text = "Order Status: In queue"
        case 2:
            statusLabel.text = "Order Status: Making"
        case 3:
            statusLabel.text = "Order Status: Delivered"
        default:
            statusLabel.text = "Order Status:"
        }
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DetailMenuViewController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 19/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class DetailMenuViewController: UIViewController {
    
    var dishDetail: Dish?
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageDish: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBAction func stepperQuantity(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func addToOrderButton(_ sender: Any) {
        var quantity: Int = 1
        if Int(quantityLabel.text!) != nil {
            quantity = Int(quantityLabel.text!)!

        }
        let newOrder: OrderRow = OrderRow(restaurant: restaurant, table: 2, dish: dishDetail!, quantity: quantity, state: 1)
        
        orders.append(newOrder)
//        OrderRowModel.addNew(orderRow: newOrder, completionHandler: <#T##(OrderRow, Error?) -> Void#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        imageDish.image = dishDetail?.photo
        nameLabel.text = dishDetail?.name
        descriptionLabel.text = dishDetail?.descr

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

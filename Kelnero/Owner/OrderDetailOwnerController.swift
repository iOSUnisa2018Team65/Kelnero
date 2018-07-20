//
//  OrderDetailOwnerController.swift
//  Kelnero
//
//  Created by Panariello Aniello on 19/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrderDetailOwnerController: UIViewController {
    
    var orderDetail: Dish?
    var quantity: Int?
    var table: Int?
    
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = orderDetail?.photo
        nameLabel.text = orderDetail?.name
        quantityLabel.text = "Quantity: \(quantity?.description)!"
        tableLabel.text = "Table: \(table?.description)!"
        
        

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

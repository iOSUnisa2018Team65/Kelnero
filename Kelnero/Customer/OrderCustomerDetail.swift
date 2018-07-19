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
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBAction func deleteDishFromOrder(_ sender: Any) {
        orders.remove(at: orderIdx!)
        //da implementare icloud
        //OrderRowModel.remove
        _ = navigationController?.popViewController(animated: true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = order?.dish.name
        imageDish.image = order?.dish.photo
        descriptionLabel.text = order?.dish.descr
        quantityLabel.text = order?.quantity.description
        
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

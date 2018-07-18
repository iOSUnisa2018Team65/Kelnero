//
//  OrdersCustomerTableViewCell.swift
//  Kelnero
//
//  Created by Monaco Simone on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrdersCustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOrder: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

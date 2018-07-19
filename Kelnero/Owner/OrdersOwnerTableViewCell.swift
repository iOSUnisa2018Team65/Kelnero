//
//  OrdersOwnerTableViewCell.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 19/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrdersOwnerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

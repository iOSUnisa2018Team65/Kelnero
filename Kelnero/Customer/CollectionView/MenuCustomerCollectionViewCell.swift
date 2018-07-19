//
//  MenuCustomerCollectionViewCell.swift
//  Kelnero
//
//  Created by Panariello Aniello on 16/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class MenuCustomerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        self.layer.cornerRadius = 3
        
        
        
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel.text = nil
        self.image.image = UIImage(named: "Image")!
    }
}

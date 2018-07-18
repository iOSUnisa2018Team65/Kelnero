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
        
        self.contentView.backgroundColor = UIColor(red: 230.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 2
        
        
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel.text = nil
        self.image.image = UIImage(named: "Image")!
    }
}

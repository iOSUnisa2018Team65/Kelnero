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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//            let textLabel = UILabel(frame: .zero)
//            textLabel.translatesAutoresizingMaskIntoConstraints = false
//            self.contentView.addSubview(textLabel)
//            NSLayoutConstraint.activate([
//                textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//                textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//                textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//                textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//                ])
        
//            self.textLabel = textLabel
        
        self.contentView.backgroundColor = .lightGray
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.masksToBounds = true
        self.textLabel.textAlignment = .center

        
}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel.text = nil
    }
}

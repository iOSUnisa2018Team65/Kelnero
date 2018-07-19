//
//  SectionHeaderView.swift
//  Kelnero
//
//  Created by Panariello Aniello on 18/07/18.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var SectionLabel: UILabel!
    var sectionTitle: String!{
        didSet {
            SectionLabel.text = sectionTitle
        }
    }
    
    override func awakeFromNib() {
        
    }
}

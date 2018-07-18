//
//  Restaurant.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class Restaurant: NSObject {

    var id: String
    var name: String
    var address: String
    
    init(ownerIcloudId id: String, name n: String, address addr: String) {
        self.id = id
        self.name = n
        self.address = addr
    }
    
}

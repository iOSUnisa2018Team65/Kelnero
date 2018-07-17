//
//  Dish.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class Dish: NSObject {

    var restaurant: Restaurant
    var name: String
    var price: Double
    var descr: String
    var photo: UIImage
    
    init(restaurant: Restaurant, name: String, price: Double, description: String, photo: UIImage) {
        self.restaurant = restaurant
        self.name = name
        self.price = price
        self.descr = description
        self.photo = photo
    }
    
}

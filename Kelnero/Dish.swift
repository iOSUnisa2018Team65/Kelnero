//
//  Dish.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 16/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class Dish: NSObject {

    var restaurant: Restaurant
    var id: Int
    var name: String
    var price: Double
    var descr: String
    
    init(restaurant: Restaurant, id: Int, name: String, price: Double, description: String) {
        self.restaurant = restaurant
        self.id = id
        self.name = name
        self.price = price
        self.descr = description
    }
}

//
//  OrderRow.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

class OrderRow: NSObject {

    var restaurant: Restaurant
    var table: Int
    var dish: Dish
    var quantity: Int
    var state: Int
    
    init(restaurant: Restaurant, table: Int, dish: Dish, quantity: Int, state: Int) {
        self.restaurant = restaurant
        self.table = table
        self.dish = dish
        self.quantity = quantity
        self.state = state
    }

}

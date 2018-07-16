//
//  RestaurantModel.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 16/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import CloudKit

class RestaurantModel: NSObject {

    // table and fields names
    static let recordType = "Restaurant"
    static let nameField = "name"
    static let addressField = "address"

    
    // async saving: the caller must give a completion handler
    class func save(restaurant: Restaurant, completionHandler handler: @escaping (Restaurant, Error?) -> Void) {
        let recordId = CKRecordID(recordName: restaurant.id)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        record[nameField] = restaurant.name as NSString
        record[addressField] = restaurant.address as NSString
        
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        
        db.save(record) {
            (recordSaved, error) in
            if let error = error {
                handler(restaurant, error)
                return
            }
            handler(restaurant, nil)
        }
    }
    
    
    
    /*
     let restaurantId = userId.dropFirst()
     let r = Restaurant(ownerIcloudId: String(restaurantId), name: "Prova", address: "Via ecc ecc")
     RestaurantModel.save(restaurant: r) {
     (restaurant, error) in
     if let e = error {
     print(e)
     }
     else {
     print("OK")
     }
     }
     */
}

//
//  DishModel.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import CloudKit

class DishModel: NSObject {

    // table and fields names
    static let recordType = "Dish"
    static let restaurantIdField = "restaurant_Id"
    static let nameField = "name"
    static let priceField = "price"
    static let descriptionField = "descr"
    static let imageField = "image"
    
    
    class func addNew(dish dishToAdd: Dish, completionHandler handler: @escaping (Dish, Error?) -> Void) {
        
        let key = dishToAdd.restaurant.id + "_" + dishToAdd.name
        let recordId = CKRecordID(recordName: key)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        record[restaurantIdField] = dishToAdd.restaurant.id as NSString
        record[nameField] = dishToAdd.name as NSString
        record[priceField] = dishToAdd.price as NSNumber
        record[descriptionField] = dishToAdd.descr as NSString
        
        // image will have same name as dish
        let resourceName = key
        let imgPng = UIImagePNGRepresentation(dishToAdd.photo)
        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        // Create a destination URL.
        let targetURL = tempDirectoryURL.appendingPathComponent("\(resourceName).png")
        // Write the image locally.
        do {
            try imgPng?.write(to: targetURL)
        } catch let error {
            print("Error in adding a new dish")
            NSLog("Unable to write file: \(error)")
        }
        let asset = CKAsset(fileURL: targetURL)
        record[imageField] = asset
        
        // saving
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        
        db.save(record) {
            (savedRecord, error) in
            handler(dishToAdd, error)
        }
        /*
        
        
        
        var ownerID = ""
        IcloudUtils.asyncGetCurrentUserId() {
            (str, error) in
            if let e = error {
                print(e)
            }
            else {
                ownerID = str
                
                let restaurantId = ownerID.dropFirst()
                var r = Restaurant(ownerIcloudId: String(restaurantId), name: "Prova", address: "Via ecc ecc")
                RestaurantModel.save(restaurant: r) {
                    (restaurant, error) in
                    if let e = error {
                        print(e)
                    }
                    else {
                        print("OK")
                        r = restaurant
                        
                        let asdf = restaurantId + "_" + name
                        let recordId = CKRecordID(recordName: asdf)
                        let record = CKRecord(recordType: recordType, recordID: recordId)
                        record[restaurantIdField] = restaurantId as NSString
                        record[nameField] = name as NSString
                        record[priceField] = price as NSNumber
                        record[descriptionField] = desc as NSString
                        
                        
                        var resourceName = asdf
                        var imgPng = UIImagePNGRepresentation(image)
                        
                        let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
                        
                        // Create a destination URL.
                        let targetURL = tempDirectoryURL.appendingPathComponent("\(resourceName).png")
                        
                       
                        
                        // Copy the file.
                        do {
                            try imgPng?.write(to: targetURL)
                        } catch let error {
                            NSLog("Unable to write file: \(error)")
                        }
                        
                        var asset = CKAsset(fileURL: targetURL)
                        record[imageField] = asset
                        
                        
                        
                        let container = CKContainer.default()
                        let db = container.publicCloudDatabase
                        
                        var dish = Dish(restaurant: r, id: 0, name: name, price: price, description: desc)
                        db.save(record) {
                            (recordSaved, error) in
                            if let error = error {
                                handler(dish, error)
                                return
                            }
                            handler(dish, nil)
                        }
                    }
                }
                
            }
        } */
        
    }
}

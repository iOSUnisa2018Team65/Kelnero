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
    static let categoryField = "category"
    static let descriptionField = "descr"
    static let photoField = "image"
    
    
    class func addNew(dish dishToAdd: Dish, completionHandler handler: @escaping (Dish, Error?) -> Void) {
        
        let key = dishToAdd.restaurant.id + "_" + dishToAdd.name
        let recordId = CKRecordID(recordName: key)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        record[restaurantIdField] = dishToAdd.restaurant.id as NSString
        record[nameField] = dishToAdd.name as NSString
        record[priceField] = dishToAdd.price as NSNumber
        record[categoryField] = dishToAdd.category as NSString
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
        record[photoField] = asset
        
        // saving
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        
        db.save(record) {
            (savedRecord, error) in
            handler(dishToAdd, error)
        }
    }
    
    
    class func getAllDishesByRestaurantId(restaurantId restId: String, completionHandler handler: @escaping ([[Dish]], Error?) -> (Void)) {
        var menu = [[Dish]]()
        var categories = [String]()
        var whereClause = NSPredicate(format: "%K == %@", restaurantIdField, restId)
        var query = CKQuery(recordType: recordType, predicate: whereClause)
        var rest: Restaurant? = nil
        RestaurantModel.getById(idToSearch: restId) {
            (r, error) in
            if let e = error {
                handler(menu, e)
                return
            }
            else {
                rest = r!
                
                let container = CKContainer.default()
                let db = container.publicCloudDatabase
                
                db.perform(query, inZoneWith: nil) {
                    (records, error) in
                    if let e = error {
                        handler(menu, e)
                    }
                    else {
                        records?.forEach() { fetchedRecord in
                            var name = fetchedRecord[nameField] as! String
                            var price = fetchedRecord[priceField] as! Double
                            var category = fetchedRecord[categoryField] as! String
                            var descr = fetchedRecord[descriptionField] as! String
                            var asset = fetchedRecord[photoField] as! CKAsset
                            var assetUrl = asset.fileURL
                            var img = NSData(contentsOf: assetUrl)
                            var photo = UIImage(data: img as! Data)!
                            var d = Dish(restaurant: rest!, name: name, price: price, category: category, description: descr, photo: photo)
                            if categories.contains(category) {
                                var i = categories.index(of: category)!
                                menu[i].append(d)
                            }
                            else {
                                categories.append(category)
                                menu.append([Dish]())
                                var i = categories.index(of: category)!
                                menu[i].append(d)
                            }
                            print("Retrieved dish \(d.name) in category \(d.category)")
                        }
                        handler(menu, nil)
                    }
                }
            }
        }
    }
    
}

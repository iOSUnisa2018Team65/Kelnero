//
//  RestaurantModel.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import CloudKit

class RestaurantModel: NSObject {

    // table and fields names
    static let recordType = "Restaurant"
    static let idField = "id"
    static let nameField = "name"
    static let addressField = "address"
    
    
    // async saving: the caller must give a completion handler
    class func addNew(restaurant: Restaurant, completionHandler handler: @escaping (Restaurant, Error?) -> Void) {
        let recordId = CKRecordID(recordName: restaurant.id)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        record[idField] = restaurant.id as NSString
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
    
    
    class func getById(idToSearch: String, completionHandler handler: @escaping (Restaurant?, Error?) -> (Void)) {
        // do not let fetchedRestaurant
        var fetchedRestaurant: Restaurant? = nil
        // we want that content in idField is equal to the passed id to search
        let whereClause = NSPredicate(format: "%K == %@", idField, idToSearch)
        let query = CKQuery(recordType: recordType, predicate: whereClause)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 1 // one and only one record matches id
        queryOperation.recordFetchedBlock = { fetchedRecord in
            let id = fetchedRecord[idField] as! String
            let name = fetchedRecord[nameField] as! String
            let address = fetchedRecord[addressField] as! String
            fetchedRestaurant = Restaurant(ownerIcloudId: id, name: name, address: address)
            handler(fetchedRestaurant, nil)
        }
        
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        
        db.add(queryOperation)
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

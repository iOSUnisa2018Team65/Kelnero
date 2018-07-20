//
//  OrderRowModel.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import CloudKit

class OrderRowModel: NSObject {
    
    // table and fields names
    static let recordType = "OrderRow"
    static let restaurantIdField = "restaurant_Id"
    static let tableField = "table"
    static let dishField = "dish_Name"
    static let quantityField = "quantity"
    static let stateField = "state"
    
    
    class func addNew(orderRow toAdd: OrderRow, completionHandler handler: @escaping (OrderRow, Error?) -> Void) {
        print("Saving order row")
        let key = toAdd.restaurant.id + "_" + String(toAdd.table) + "_" + toAdd.dish.name
        let recordId = CKRecordID(recordName: key)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        
        record[restaurantIdField] = toAdd.restaurant.id as NSString
        record[tableField] = toAdd.table as NSNumber
        record[dishField] = toAdd.dish.name as NSString
        record[quantityField] = toAdd.quantity as NSNumber
        record[stateField] = toAdd.state as NSNumber
        
        // saving
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        
        db.save(record) {
            (savedRecord, error) in
            handler(toAdd, error)
        }
    }
    
    
    class func getAllOrderRowsByTable(restaurantId restId: String, tableNumber t: Int, completionHandler handler: @escaping ([OrderRow], Error?) -> (Void)) {
        var orders = [OrderRow]()
        var predicate1:NSPredicate = NSPredicate(format: "%K == %@", restaurantIdField, restId)
        var predicate2:NSPredicate = NSPredicate(format: "%K == %@", tableField, t as NSNumber)
        var whereClause:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2] )
        //var whereClause = NSPredicate(format: "%K == %@ AND %K == %@", restaurantIdField, restId, tableField, t)
        var query = CKQuery(recordType: recordType, predicate: whereClause)
        var rest: Restaurant? = nil
        RestaurantModel.getById(idToSearch: restId) {
            (r, error) in
            if let e = error {
                handler(orders, e)
                return
            }
            else {
                rest = r!
                
                let container = CKContainer.default()
                let db = container.publicCloudDatabase
                
                db.perform(query, inZoneWith: nil) {
                    (records, error) in
                    if let e = error {
                        handler(orders, e)
                    }
                    else {
                        for fetchedRecord in records! {
                            
                            var table = fetchedRecord[tableField] as! Int
                            var quantity = fetchedRecord[quantityField] as! Int
                            var state = fetchedRecord[stateField] as! Int
                            var dishName = fetchedRecord[dishField] as! String
                            DishModel.getDishByName(restaurantId: restId, dishName: dishName) {
                                (d, error) in
                                if let e = error {
                                    print(e)
                                }
                                else {
                                    var order = OrderRow(restaurant: rest!, table: table, dish: d!, quantity: quantity, state: state)
                                    orders.append(order)
                                    print("Retrieved order for dish \(order.dish.name) in table \(order.table)")
                                }
                            }
                        }
                       handler(orders, nil)
                    }
                    
                }
            }
        }
    }

    
    
    class func getAllOrders(restaurantId restId: String) -> [OrderRow] {
        var allOrders = [OrderRow]()
        var whereClause = NSPredicate(format: "%K == %@", restaurantIdField, restId)
        var query = CKQuery(recordType: recordType, predicate: whereClause)
        var rest: Restaurant? = nil
        RestaurantModel.getById(idToSearch: restId) {
            (r, error) in
            if let e = error {
                print(e)
            }
            else {
                rest = r!
                
                let container = CKContainer.default()
                let db = container.publicCloudDatabase
                
                db.perform(query, inZoneWith: nil) {
                    (records, error) in
                    if let e = error {
                        print(e)
                    }
                    else {
                        records?.forEach() {
                            fetchedRecord in
                            var table = fetchedRecord[tableField] as! Int
                            DishModel.getDishByName(restaurantId: restId, dishName: fetchedRecord[dishField] as! String) {
                                (d, error) in
                                if let e = error {
                                    print(e)
                                }
                                else {
                                    var quantity = fetchedRecord[quantityField] as! Int
                                    var state = fetchedRecord[stateField] as! Int
                                    var o = OrderRow(restaurant: rest!, table: table, dish: d!, quantity: quantity, state: state)
                                    orders.append(o)
                                    print("Retrieved order \(o)")
                                }
                            }
                        }
                    }
                }
            }
        }
        return orders
    }
    
    
    class func delete(orderRow orderRow: OrderRow, completionHandler handler: @escaping (Error?)->Void) {
        let container = CKContainer.default()
        let db = container.publicCloudDatabase
        var key = orderRow.restaurant.id.description + "_" + orderRow.table.description + "_" + orderRow.dish.name
        var id = CKRecordID(recordName: key)
        db.delete(withRecordID: id) {
            (record, error) in
            handler(error)
        }
    }
    
    
}

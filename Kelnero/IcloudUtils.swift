//
//  IcloudUtils.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 17/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit
import CloudKit

class IcloudUtils: NSObject {

    /// async gets iCloud record name of current logged-in user
    class func asyncGetCurrentUserId(completionHandler: @escaping (String, Error?) -> ()) {
        var currentUserId = ""
        let container = CKContainer.default()
        // we need icloud email: user must grant permission
        container.requestApplicationPermission(.userDiscoverability) { (status, error) in
            switch status {
            case .granted:
                print("iCloud permission is granted. OK")
            case .initialState:
                print("The user has not yet decided whether to grant iCloud permission.")
                completionHandler("NOT_YET", nil)
                return
            case .couldNotComplete:
                print("An error occurred during the getting or setting of the app permission for iCloud.")
                if let error = error {
                    print("err @ \(#function) -> \(error.localizedDescription)")
                    completionHandler("", error)
                }
                return
            case .denied:
                print("iCloud permission is DENIED.")
                completionHandler("DENIED", nil)
                return
            }
            // fetching user id (only happens if permission was GRANTED)
            container.fetchUserRecordID { (record, error) in
                if #available(iOS 10.0, *) {
                    CKContainer.default().discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in
                        if error == nil {
                            currentUserId = (userID?.userRecordID?.recordName)!
                            print("Current user iCloud ID is: \(currentUserId)")
                            // calling the completion handler: this func is ASYNCHRONOUS so we need to handle its end
                            completionHandler(currentUserId, nil)
                        } else {
                            completionHandler("", error)
                        }
                    })
                }
                else {
                    // TODO Fallback on earlier versions
                }
            }
        }
    }
    
}

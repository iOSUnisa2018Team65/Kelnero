//
//  QrCodeUtils.swift
//  Kelnero
//
//  Created by Sellitto Giulia on 13/07/2018.
//  Copyright © 2018 Team 6_5. All rights reserved.
//

import UIKit

// this class provides some functions for QR codes management
class QrCodeUtils: NSObject {

    class func generateQRCodeFromString(from string:String) -> UIImage? {
        let dataString = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(dataString, forKey: "inputMessage")
            // default output is too small and doesn't render good in imageview
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
}

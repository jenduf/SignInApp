//
//  NSObject+Helpers.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

extension NSObject
{
    // Date conversion to string
    func convertDate(date: NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyy"
        return dateFormatter.stringFromDate(date)
    }
    
    // Image to str64
    func encodeImage(image: UIImage) -> String
    {
        if let imageData = UIImageJPEGRepresentation(image, 0.5)
        {
            let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            return strBase64
        }
        
        return ""
        
    }
    
    func decodeImage(imageString: String) -> UIImage?
    {
        if let imageData = NSData(base64EncodedString: imageString as String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        {
            if let image = UIImage(data: imageData)
            {
                return image
            }
        }
        
        return nil
    }
}
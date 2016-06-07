//
//  Utils.swift
//  FantasyStats
//
//  Created by Jennifer Duffey on 3/10/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class Utils
{
    class func UIColorFromRGB(colorCode: String, alpha: Float = 1.0) -> UIColor
    {
        var adjustedString: String = colorCode
        
        if colorCode.hasPrefix("#")
        {
            let index = colorCode.startIndex.advancedBy(1)
            adjustedString = colorCode.substringFromIndex(index)
        }
        
        let scanner = NSScanner(string: adjustedString)
        var color: UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
        let b = CGFloat(Float(Int(color) & mask)/255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    class func createPDFFromTableView(tableView: UITableView) -> NSData?
    {
        let pdfData = NSMutableData()
        
        let originalFrame = tableView.frame
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        
        UIGraphicsBeginPDFContextToData(pdfData, tableView.bounds, nil)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIGraphicsBeginPDFPage()
        tableView.layer.renderInContext(context!)
        
        UIGraphicsEndPDFContext()
        
        tableView.frame = originalFrame
        
        return pdfData
    }
    
    // Date conversion to string
    class func convertDate(date: NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyy"
        return dateFormatter.stringFromDate(date)
    }
    
    // Image to str64
    class func encodeImage(image: UIImage) -> String
    {
        if let imageData = UIImageJPEGRepresentation(image, 0.5)
        {
            let strBase64:String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            return strBase64
        }
        
        return ""
        
    }
    
    class func decodeImage(imageString: String) -> UIImage?
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
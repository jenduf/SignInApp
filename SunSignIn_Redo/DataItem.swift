
//
//  DataItem.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

@objc class DataItem: NSObject, NSCoding
{
    var itemID: String?
    var itemName: String?
    
    init(itemID: String, itemName: String)
    {
        self.itemID = itemID
        self.itemName = itemName
    }
    
    init(dict: NSDictionary)
    {
        self.itemID = dict["id"] as? String
        self.itemName = dict["name"] as? String
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.itemID, forKey: "itemID")
        aCoder.encodeObject(self.itemName, forKey: "itemName")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.itemID = aDecoder.decodeObjectForKey("itemID") as? String
        self.itemName = aDecoder.decodeObjectForKey("itemName") as? String
    }
}
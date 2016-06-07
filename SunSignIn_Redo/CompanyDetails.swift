
//
//  CompanyDetails.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

@objc class CompanyDetails: NSObject, NSCoding
{
    var logo: String?
    var companyID: String?
    var companyName: String?
    var companyDescription: String?
    
    init(json: NSDictionary)
    {
        //super.init()
        
        if let logoString = json["logoimage"] as? String
        {
            self.logo = logoString //Utils.decodeImage(logoString)
        }
        
        if let companyID = json["id"] as? String
        {
            self.companyID = companyID
        }
        
        if let companyName = json["company_name"] as? String
        {
            self.companyName = companyName
        }
        
        if let companyDescription = json["description"] as? String
        {
            self.companyDescription = companyDescription
        }
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.logo, forKey: "logo")
        aCoder.encodeObject(self.companyID, forKey: "companyID")
        aCoder.encodeObject(self.companyName, forKey: "companyName")
        aCoder.encodeObject(self.companyDescription, forKey: "companyDescription")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.logo = aDecoder.decodeObjectForKey("logo") as? String
        self.companyID = aDecoder.decodeObjectForKey("companyID") as? String
        self.companyName = aDecoder.decodeObjectForKey("companyName") as? String
        self.companyDescription = aDecoder.decodeObjectForKey("companyDescription") as? String
    }
}
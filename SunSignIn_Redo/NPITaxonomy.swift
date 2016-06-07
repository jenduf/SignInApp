//
//  NPITaxonomy.swift
//  Sign In
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation

@objc class NPITaxonomy: NSObject, NSCoding
{
    var code: NSString?
    var taxonomyDescription: NSString?
    var license: NSString?
    var primary: Bool = false
    var state: String?
    
    init(json: NSDictionary)
    {
        if let code = json["code"] as? String
        {
            self.code = code
        }
        
        if let description = json["desc"] as? String
        {
            self.taxonomyDescription = description
        }
        
        if let license = json["license"] as? String
        {
            self.license = license
        }
        
        if let primaryString = json["primary"] as? String
        {
            self.primary = primaryString.toBool()
        }
        
        if let state = json["state"] as? String
        {
            self.state = state
        }
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.code, forKey: "code")
        aCoder.encodeObject(self.taxonomyDescription, forKey: "taxonomyDescription")
        aCoder.encodeObject(self.license, forKey: "license")
        aCoder.encodeBool(self.primary, forKey: "primary")
        aCoder.encodeObject(self.state, forKey: "state")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.code = aDecoder.decodeObjectForKey("code") as? String
        self.taxonomyDescription = aDecoder.decodeObjectForKey("taxonomyDescription") as? String
        self.license = aDecoder.decodeObjectForKey("license") as? String
        self.primary = aDecoder.decodeBoolForKey("primary")
        self.state = aDecoder.decodeObjectForKey("state") as? String
    }
}
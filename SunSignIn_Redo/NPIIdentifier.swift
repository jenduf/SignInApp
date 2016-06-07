//
//  NPIIdentifier.swift
//  Sign In
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation

@objc class NPIIdentifier: NSObject, NSCoding
{
    var code: String?
    var identifierDescription: String?
    var identifier: String?
    var issuer: String?
    var state: String?
    
    init(json: NSDictionary)
    {
        if let code = json["code"] as? String
        {
            self.code = code
        }
        
        if let desc = json["desc"] as? String
        {
            self.identifierDescription = desc
        }
        
        if let identifier = json["identifier"] as? String
        {
            self.identifier = identifier
        }
        
        if let issuer = json["issuer"] as? String
        {
            self.issuer = issuer
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
        aCoder.encodeObject(self.identifierDescription, forKey: "identifierDescription")
        aCoder.encodeObject(self.identifier, forKey: "identifier")
        aCoder.encodeObject(self.issuer, forKey: "issuer")
        aCoder.encodeObject(self.state, forKey: "state")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.code = aDecoder.decodeObjectForKey("code") as? String
        self.identifierDescription = aDecoder.decodeObjectForKey("identifierDescription") as? String
        self.identifier = aDecoder.decodeObjectForKey("identifier") as? String
        self.issuer = aDecoder.decodeObjectForKey("issuer") as? String
        self.state = aDecoder.decodeObjectForKey("state") as? String
    }
}
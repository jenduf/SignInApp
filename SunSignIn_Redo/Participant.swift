
//
//  Participant.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/31/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

@objc class Participant: NSObject, NSCoding
{
    var participantID: String?
    var firstName: String?
    var lastName: String?
    var title: String?
    var city: String?
    var state: DataItem?
    var signature: UIImage?
    var npiObject: NPIObject?
    var meal: Bool = true
    
    static var currentParticipant: Participant?
    {
        get
        {
            if let participant = PersistenceManager.sharedManager.loadData(.Participant)
            {
                return participant as? Participant
            }
            
            return Participant()
        }
        
        set
        {
            PersistenceManager.sharedManager.saveData(newValue!, path: .Participant)
        }
    }
    
    override init()
    {
        super.init()
    }
    
    func getMealString() -> String
    {
        if self.meal == true
        {
            return "YES"
        }
        
        return "NO"
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.participantID, forKey: "participantID")
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.city, forKey: "city")
        aCoder.encodeObject(self.state, forKey: "state")
        aCoder.encodeObject(self.signature, forKey: "signature")
        aCoder.encodeObject(self.npiObject, forKey: "npiObject")
        aCoder.encodeBool(self.meal, forKey: "meal")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.participantID = aDecoder.decodeObjectForKey("participantID") as? String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.city = aDecoder.decodeObjectForKey("city") as? String
        self.state = aDecoder.decodeObjectForKey("state") as? DataItem
        self.signature = aDecoder.decodeObjectForKey("signature") as? UIImage
        self.npiObject = aDecoder.decodeObjectForKey("npiObject") as? NPIObject
        self.meal = aDecoder.decodeBoolForKey("meal")
    }
    
    func isHCP() -> Bool
    {
        if self.title != nil
        {
            return self.title!.lowercaseString.containsString("physician") || self.title!.lowercaseString.containsString("nurse practitioner")
        }
        
        return false
    }
}
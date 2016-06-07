
//
//  EventItem.swift
//  Sign In
//
//  Created by Jennifer Duffey on 5/26/16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import FirebaseDatabase

@objc class EventItem: NSObject, NSCoding
{
    var key: String?
    var eventID: String?
    var eventDate: NSDate?
    var receiptNumber: String?
    var repName: String?
    var company: String?
    var department: String?
    var practice: String?
    var merchantName: String?
    var city: String?
    var state: String?
    var mealCost: String?
    var products: String?
    var title: String?
    var type: String?
    var logo: UIImage?
    var receiptImage: UIImage?
    var participants = [Participant]()
    //var ref: FIRDatabaseReference?
    
    
    static var currentEventItem: EventItem?
    {
        get
        {
            if let eventItem = PersistenceManager.sharedManager.loadData(.Event)
            {
                return eventItem as? EventItem
            }
            
            return EventItem()
        }
        
        set
        {
            PersistenceManager.sharedManager.saveData(newValue!, path: .Event)
        }
    }
    
    override init()
    {
        super.init()
    }
  
    init(key: String, eventID: String, eventDict: NSDictionary)
    {
        self.key = key
        
        self.eventID = eventID
        
        if let dictionaryDetail = eventDict[eventID] as? NSDictionary
        {
            if let eventDateString = dictionaryDetail["dateTime"] as? String
            {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "MMddyy"
                self.eventDate = formatter.dateFromString(eventDateString)
            }
            
            if let receiptNumber = dictionaryDetail["receiptNumber"] as? String
            {
                self.receiptNumber = receiptNumber
            }
            
            if let repName = dictionaryDetail["repName"] as? String
            {
                self.repName = repName
            }
            
            if let company = dictionaryDetail["company"] as? String
            {
                self.company = company
            }
            
            if let department = dictionaryDetail["department"] as? String
            {
                self.department = department
            }
            
            if let practice = dictionaryDetail["practice"] as? String
            {
                self.practice = practice
            }
            
            if let merchantName = dictionaryDetail["merchantName"] as? String
            {
                self.merchantName = merchantName
            }
            
            if let city = dictionaryDetail["city"] as? String
            {
                self.city = city
            }
            
            if let state = dictionaryDetail["state"] as? String
            {
                self.state = state
            }
            
            if let mealCost = dictionaryDetail["mealCost"] as? String
            {
                self.mealCost = mealCost
            }
            
            if let products = dictionaryDetail["products"] as? String
            {
                self.products = products
            }
            
            if let title = dictionaryDetail["title"] as? String
            {
                self.title = title
            }
            
            if let type = dictionaryDetail["type"] as? String
            {
                self.type = type
            }
            
            
            
            if let logoString = dictionaryDetail["logo"] as? String
            {
                if let decodedImage = Utils.decodeImage(logoString)
                {
                    self.logo = decodedImage
                }
            }
            
            if let receiptString = dictionaryDetail["receiptImage"] as? String
            {
                if let decodedImage = Utils.decodeImage(receiptString)
                {
                    self.receiptImage = decodedImage
                }
            }
        }
        
       // super.init()
    }
    
    // Create the dict for Firebase all setup
    func createDict() -> [String: AnyObject]
    {
        
        let dict: [String: AnyObject] =
            [
                "logo" : Utils.encodeImage(self.logo!),
                "receiptImage" : Utils.encodeImage(self.receiptImage!),
                "city" : self.city!,
                "dateTime": Utils.convertDate(self.eventDate!),
                "mealCost" : self.mealCost!,
                "merchantName" : self.merchantName!,
                "products" : self.products!,
                "receiptNumber" : self.receiptNumber!,
                "repName": self.repName!,
                "state" : self.state!,
                "title" : self.title!,
                "type": self.type!,
                "company" : self.company!,
                "practice": self.practice!,
                "department": self.department!
        ]
        
        return dict
        
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.key, forKey: "key")
        aCoder.encodeObject(self.eventID, forKey: "eventID")
        aCoder.encodeObject(self.eventDate, forKey: "eventDate")
        aCoder.encodeObject(self.receiptNumber, forKey: "receiptNumber")
        aCoder.encodeObject(self.repName, forKey: "repName")
        aCoder.encodeObject(self.company, forKey: "company")
        aCoder.encodeObject(self.department, forKey: "department")
        aCoder.encodeObject(self.practice, forKey: "practice")
        aCoder.encodeObject(self.merchantName, forKey: "merchantName")
        aCoder.encodeObject(self.city, forKey: "city")
        aCoder.encodeObject(self.mealCost, forKey: "mealCost")
        aCoder.encodeObject(self.products, forKey: "products")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.type, forKey: "type")
        aCoder.encodeObject(self.logo, forKey: "logo")
        aCoder.encodeObject(self.receiptImage, forKey: "receiptImage")
        aCoder.encodeObject(self.participants, forKey: "participants")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.key = aDecoder.decodeObjectForKey("key") as? String
        self.eventID = aDecoder.decodeObjectForKey("eventID") as? String
        self.eventDate = aDecoder.decodeObjectForKey("eventDate") as? NSDate
        self.receiptNumber = aDecoder.decodeObjectForKey("receiptNumber") as? String
        self.repName = aDecoder.decodeObjectForKey("repName") as? String
        self.company = aDecoder.decodeObjectForKey("company") as? String
        self.department = aDecoder.decodeObjectForKey("department") as? String
        self.practice = aDecoder.decodeObjectForKey("practice") as? String
        self.merchantName = aDecoder.decodeObjectForKey("merchantName") as? String
        self.city = aDecoder.decodeObjectForKey("city") as? String
        self.mealCost = aDecoder.decodeObjectForKey("mealCost") as? String
        self.products = aDecoder.decodeObjectForKey("products") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.type = aDecoder.decodeObjectForKey("type") as? String
        self.logo = aDecoder.decodeObjectForKey("logo") as? UIImage
        self.receiptImage = aDecoder.decodeObjectForKey("receiptImage") as? UIImage
        
        if let participants = aDecoder.decodeObjectForKey("participants") as? [Participant]
        {
            self.participants = participants
        }
    }
    
    func getParticipantCount() -> ParticipantCount
    {
        var hcpCount = 0
        var staffCount = 0
        var deniedCount = 0
        
        for participant in self.participants
        {
            if (participant as Participant).isHCP() == true
            {
                hcpCount += 1
            }
            else
            {
                staffCount += 1
            }
            
            if (participant as Participant).meal == false
            {
                deniedCount += 1
            }
        }
        
        let participantCount = ParticipantCount(totalParticipants: self.participants.count, totalHCPs: hcpCount, totalStaff: staffCount, totalDenied: deniedCount)
        
        return participantCount
    }
    
    func getCostPerPerson() -> String
    {
        let cost = Float(self.mealCost!)
        
        var personNum = self.getParticipantCount().totalHCPs + self.getParticipantCount().totalStaff
        
        if personNum == 0
        {
            personNum = 1
        }
        
        let perPerson = cost! / Float(personNum)
        
        return "$\(perPerson)"
    }
}
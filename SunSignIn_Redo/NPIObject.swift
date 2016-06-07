//
//  NPIObject.swift
//  
//
//  Created by Jennifer Duffey on 3/28/16.
//
//

import Foundation
import CoreData


@objc class NPIObject: NSObject, NSCoding
{
    var npiNumber: String?
    var taxonomy: String?
    var license: String?
    var address: String?
    var state: String?
    var city: String?
    var phone: String?
    
    var identifiers = [NPIIdentifier]()
    var taxonomies = [NPITaxonomy]()
    
    /*
    class func emptyNPIObject() -> NPIObject
    {
        return NSEntityDescription.insertNewObjectForEntityForName("NPIObject", inManagedObjectContext: DataBase.shared.context!) as! NPIObject
    }
    */
    static func npiList(results : [[String : AnyObject]]) -> [NPIObject]?
    {
        var objects = [NPIObject]()
        
        for result in results
        {
            print(result)
            
            objects.append(NPIObject(json: result as NSDictionary))
        }
        
        return objects
    }
    
    init(json: NSDictionary)
    {
       // let npiObject = NPIObject()
        
        if let npiNumber = json["number"] as? Int
        {
            self.npiNumber = "\(npiNumber)"
        }
        
        let taxonomies = json["taxonomies"] as! [[String : AnyObject]]
        let taxonomy = taxonomies.first!
        let license = taxonomy["license"] as! String
        let taxDesc  = taxonomy["desc"] as! String
        let taxCode  = taxonomy["code"] as! String
        
        self.taxonomy = "\(taxDesc) (\(taxCode))"
        self.license  = license
        
        let addresses  = json["addresses"] as! [[String : AnyObject]]
        let address = addresses.first!
        
        let address1 = address["address_1"] as! String
        var address2 = address["address_2"] as! String
        address2 = address2.characters.count > 0 ? ", " + address2 : ""
        
        self.address = address1 + address2
        self.city    = address["city"] as? String
        self.state   = address["state"] as? String
        self.phone = address["telephone_number"] as? String
        
        if let identifiers = json["identifiers"] as? NSArray
        {
            for identifier in identifiers
            {
                let npiIdentifier = NPIIdentifier(json: identifier as! NSDictionary)
                self.identifiers.append(npiIdentifier)
            }
        }
        
        if let taxes = json["taxonomies"] as? NSArray
        {
            for tax in taxes
            {
                let npiTaxonomy = NPITaxonomy(json: tax as! NSDictionary)
                self.taxonomies.append(npiTaxonomy)
            }
        }
        
    }
    
  //  class func npi(dict : [String : AnyObject]) -> NPIObject
    //{
        //let object = NPIObject(json: dict)
        /*
        
        if let npiNumber = dict["number"] as? Int
        {
            object.npiNumber = "\(npiNumber)"
        }
        
        let taxonomies = dict["taxonomies"] as! [[String : AnyObject]]
        let taxonomy = taxonomies.first!
        let license = taxonomy["license"] as! String
        let taxDesc  = taxonomy["desc"] as! String
        let taxCode  = taxonomy["code"] as! String
        
        object.taxonomy = "\(taxDesc) (\(taxCode))"
        object.license  = license
        
        let addresses  = dict["addresses"] as! [[String : AnyObject]]
        let address = addresses.first!
        
        let address1 = address["address_1"] as! String
        var address2 = address["address_2"] as! String
        address2 = address2.characters.count > 0 ? ", " + address2 : ""
        
        object.address = address1 + address2
        object.city    = address["city"] as? String
        object.state   = address["state"] as? String
        object.phone = address["telephone_number"] as? String
        */
        
       // return object
        
   // }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.npiNumber, forKey: "npiNumber")
        aCoder.encodeObject(self.taxonomy, forKey: "taxonomy")
        aCoder.encodeObject(self.license, forKey: "license")
        aCoder.encodeObject(self.address, forKey: "address")
        aCoder.encodeObject(self.city, forKey: "city")
        aCoder.encodeObject(self.state, forKey: "state")
        aCoder.encodeObject(self.phone, forKey: "phone")
        aCoder.encodeObject(self.identifiers, forKey: "identifiers")
        aCoder.encodeObject(self.taxonomies, forKey: "taxonomies")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.npiNumber = aDecoder.decodeObjectForKey("npiNumber") as? String
        self.taxonomy = aDecoder.decodeObjectForKey("taxonomy") as? String
        self.license = aDecoder.decodeObjectForKey("license") as? String
        self.address = aDecoder.decodeObjectForKey("address") as? String
        self.city = aDecoder.decodeObjectForKey("city") as? String
        self.state = aDecoder.decodeObjectForKey("state") as? String
        self.phone = aDecoder.decodeObjectForKey("phone") as? String
        self.identifiers = aDecoder.decodeObjectForKey("identifiers") as! [NPIIdentifier]
        self.taxonomies = aDecoder.decodeObjectForKey("taxonomies") as! [NPITaxonomy]
    }
}

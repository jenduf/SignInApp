
//
//  User.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

@objc class User: NSObject, NSCoding
{
    var userID: String?
    var companyID: String?
    var titleID: String?
    var departmentID: String?
    var email: String?
    var fullName: String?
    var firstName: String?
    var lastName: String?
    var isAdmin: Bool = false
    var password: String?
    var userName: String?
    var companyDetails: CompanyDetails?
    var titles = [DataItem]()
    var departments = [DataItem]()
    var products = [DataItem]()
    
    static var currentUser: User?
    {
        get
        {
            if let user = PersistenceManager.sharedManager.loadData(.User) //as? User
            {
                if (user as? User)!.userID != nil
                {
                    return user as? User
                }
            }
            
            //let userDefaults = NSUserDefaults.standardUserDefaults()
            //if let userDict = userDefaults.dictionaryForKey(Constants.USER_DICT_KEY)
            //{
              //  return User(json: userDict)
            //}
            
            return nil
        }
        
        set
        {
            PersistenceManager.sharedManager.saveData(newValue!, path: .User)
          //  let userDefaults = NSUserDefaults.standardUserDefaults()
          //  userDefaults.setObject(newValue, forKey: Constants.USER_DICT_KEY)
        }
    }
    
    override init()
    {
        super.init()
    }
    
    init(json: NSDictionary)
    {
        self.userID = json["id"] as? String
        self.companyID = json["company_id"] as? String
        self.departmentID = json["department_id"] as? String
        self.email = json["email"] as? String
        self.fullName = json["employee_name"] as? String
        self.firstName = json["firstname"] as? String
        self.lastName = json["lastname"] as? String
        self.password = json["password"] as? String
        self.titleID = json["title_id"] as? String
        self.userName = json["user_name"] as? String
        
        if let isAdmin = json["isAdmin"] as? String
        {
            self.isAdmin = isAdmin.toBool()
        }
        
        //let isAdmin = json["isAdmin"] as! Int
        //self.isAdmin = isAdmin.toBool()
    }
    
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.userID, forKey: "userID")
        aCoder.encodeObject(self.companyID, forKey: "companyID")
        aCoder.encodeObject(self.departmentID, forKey: "departmentID")
        aCoder.encodeObject(self.email, forKey: "email")
        aCoder.encodeObject(self.fullName, forKey: "fullName")
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        aCoder.encodeObject(self.password, forKey: "password")
        aCoder.encodeObject(self.titleID, forKey: "titleID")
        aCoder.encodeObject(self.userName, forKey: "userName")
        aCoder.encodeBool(self.isAdmin, forKey: "isAdmin")
        aCoder.encodeObject(self.companyDetails, forKey: "companyDetails")
        aCoder.encodeObject(self.titles, forKey: "titles")
        aCoder.encodeObject(self.departments, forKey: "departments")
        aCoder.encodeObject(self.products, forKey: "products")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.userID = aDecoder.decodeObjectForKey("userID") as? String
        self.companyID = aDecoder.decodeObjectForKey("companyID") as? String
        self.departmentID = aDecoder.decodeObjectForKey("departmentID") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.fullName = aDecoder.decodeObjectForKey("fullName") as? String
        self.firstName = aDecoder.decodeObjectForKey("firstName") as? String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
        self.titleID = aDecoder.decodeObjectForKey("titleID") as? String
        self.userName = aDecoder.decodeObjectForKey("userName") as? String
        self.isAdmin = aDecoder.decodeBoolForKey("isAdmin")
        self.companyDetails = aDecoder.decodeObjectForKey("companyDetails") as? CompanyDetails
        
        if let titlesObject = aDecoder.decodeObjectForKey("titles") as? [DataItem]
        {
            self.titles = titlesObject
        }
        
        if let departmentsObject = aDecoder.decodeObjectForKey("departments") as? [DataItem]
        {
            self.departments = departmentsObject
        }
        
        if let productsObject = aDecoder.decodeObjectForKey("products") as? [DataItem]
        {
            self.products = productsObject
        }
    }
    
    func getTitleString() -> String
    {
        for title in self.titles
        {
            if title.itemID == self.titleID
            {
                return title.itemName!
            }
        }
        
        return ""
    }
    
    func getDepartmentString() -> String
    {
        for department in self.departments
        {
            if department.itemID == self.departmentID
            {
                return department.itemName!
            }
        }
        
        return ""
    }
}
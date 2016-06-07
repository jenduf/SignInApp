//
//  ParticipantTitle.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum ParticipantTitle: Int
{
    case PhysicianDO, PhysicianMD, NursePractitioner, PhysicianAsst, Representative, Biller, FrontDesk, MedicalAssistant, OfficeManager, Pharmacist, PharmacyStaff, RegisteredNurse, Scheduling, Other
    
    static let allValues = [ PhysicianDO, PhysicianMD, NursePractitioner, PhysicianAsst, Representative, Biller, FrontDesk, MedicalAssistant, OfficeManager, Pharmacist, PharmacyStaff, RegisteredNurse, Scheduling, Other ]
    
    static let stringValues = [ "Physician, DO", "Physician, MD", "Nurse Practitioner", "Physician's Assistant", "Representative", "Biller", "Front Desk", "Medical Assistant", "Office Manager", "Pharmacist", "Pharmacy Staff", "Registered Nurse", "Scheduling", "Other Staff" ]
    
    func getStringValue() -> String 
    {
        return ParticipantTitle.stringValues[self.rawValue]
    }
    
    static func getDataItems() -> [DataItem]
    {
        var dataItems = [DataItem]()
        
        for item in ParticipantTitle.allValues
        {
            let dataItem = DataItem(itemID: "\(item.rawValue)", itemName: item.getStringValue())
            dataItems.append(dataItem)
        }
        
        return dataItems
    }
    
    static func getTitleForString(string: String) -> ParticipantTitle?
    {
        for item in ParticipantTitle.allValues
        {
            if item.getStringValue() == string
            {
                return item
            }
        }
        
        return nil
    }
}
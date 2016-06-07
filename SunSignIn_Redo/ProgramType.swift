//
//  File.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum ProgramType: Int
{
    case Breakfast, Lunch, Dinner, Snack
    
    static let allValues = [ Breakfast, Lunch, Dinner, Snack ]
    
    static let stringValues = [ "Breakfast", "Lunch", "Dinner", "Snack"]
    
    func toString() -> String
    {
        return ProgramType.stringValues[self.rawValue]
    }
    
    static func getProgramTypes() -> [DataItem]
    {
        var programTypes = [DataItem]()
        
        for item in ProgramType.allValues
        {
            let dataItem = DataItem(itemID: "\(item.rawValue)", itemName: item.toString())
            programTypes.append(dataItem)
        }
        
        return programTypes
    }
}

//
//  State.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

class State
{
  /*  case Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware, Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana, Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana, Nebraska, Nevada, NewHampshire, NewJersey, NewMexico, NewYork, NorthCarolina, NorthDakota, Ohio, Oklahoma, Oregon, Pennsylvania, RhodeIsland, SouthCarolina, SouthDakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, WestVirginia, Wisconsin, Wyoming
    
    
    static let allValues = [ Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware, Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana, Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana, Nebraska, Nevada, NewHampshire, NewJersey, NewMexico, NewYork, NorthCarolina, NorthDakota, Ohio, Oklahoma, Oregon, Pennsylvania, RhodeIsland, SouthCarolina, SouthDakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, WestVirginia, Wisconsin, Wyoming ]
    
    static func getStringData() -> [String]
    {
        var returnData = [String]()
        
        for state in State.allValues
        {
            returnData.append(state.rawValue)
        }
        
        return returnData
    }*/
    
    init()
    {
        
    }
    
    lazy var states: [DataItem] =
    {
            return State.getStatesFromPlist()
    }()
    
    static func getStatesFromPlist() -> [DataItem]
    {
        var states = [DataItem]()
        
        let pathMC = NSBundle.mainBundle().pathForResource("states", ofType: "plist")
        let dictArray = NSArray(contentsOfFile: pathMC!)
        for dict in dictArray!
        {
            let data = DataItem(dict: dict as! NSDictionary)
            states.append(data)
        }
        
        return states
    }
}
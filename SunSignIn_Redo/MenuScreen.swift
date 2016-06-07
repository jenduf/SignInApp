//
//  MenuScreen.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

enum MenuScreen: Int
{
    case LogOut = 0, EventsList = 1, DeleteInfo = 2
    
    static let allScreens = [ LogOut, EventsList, DeleteInfo ]
    
    static let menuTitles = ["Log Out", "Events List", "Delete Info"]
    
    func getImage() -> UIImage
    {
        let imageName = self.getTitle().lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        return UIImage(named: imageName)!
    }
    
    func getTitle() -> String
    {
        let title = MenuScreen.menuTitles[self.rawValue]
        return title
    }
}
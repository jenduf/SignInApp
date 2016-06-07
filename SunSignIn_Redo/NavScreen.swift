//
//  NavScreen.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum NavScreen: Int
{
    case Settings = 0, Login = 1, Program = 2, Registration = 3, Review = 4, Report = 5
    
    static let allValues = [ Login, Program, Registration, Review, Report ]
    
    static let identifiers = ["", "LoginViewController", "ProgramInfoViewController", "RegistrationViewController", "ReviewViewController", "ReportViewController"]
    
    func getIdentifier() -> String
    {
        return NavScreen.identifiers[self.rawValue]
    }
    
    func getController() -> AnyClass
    {
        return LoginViewController.self
    }
    
    func getScreenPageIndex() -> Int
    {
        let pageIndex = Int(NavScreen.allValues.indexOf(self)!)
        return pageIndex
    }
    
}

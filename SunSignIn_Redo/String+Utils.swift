//
//  File.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

extension String
{
    func toBool() -> Bool
    {
        switch self
        {
            case "True", "true", "yes", "1":
                return true
                
            case "False", "false", "no", "0":
                return false
            
            default:
                return false
        }
    }
}
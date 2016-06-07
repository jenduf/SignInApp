
//
//  DepartmentData.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

struct DepartmentData
{
    var departmentID: String?
    var departmentValue: String?
    
    init(departmentID: String, departmentValue: String)
    {
        self.departmentID = departmentID
        self.departmentValue = departmentValue
    }
}
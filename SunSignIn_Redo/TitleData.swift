//
//  TitleData.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

struct TitleData
{
    var titleID: String?
    var titleValue: String?
    
    init(titleID: String, titleValue: String)
    {
        self.titleID = titleID
        self.titleValue = titleValue
    }
}
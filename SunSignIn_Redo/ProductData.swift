//
//  ProductData.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

struct ProductData
{
    var productID: String?
    var productName: String?
    
    init(productID: String, productName: String)
    {
        self.productID = productID
        self.productName = productName
    }
}
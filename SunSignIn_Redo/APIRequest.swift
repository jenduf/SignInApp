//
//  APIRequest.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

struct APIRequest
{
    var url: String = Constants.API_URL
    var endPoint: String?
    var requestType: String?
    var parameters: [String: String]?
    
    
}
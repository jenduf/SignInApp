//
//  APIError.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/2/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum DecodeError: ErrorType
{
    case TypeMismatch(expected: String, actual: String)
    case MissingKey(String)
    case Custom(String)
}

enum APIError: ErrorType
{
    // Can't connect to the server (maybe offline?)
    case ConnectionError(error: NSError)
    
    // The server responded with a non 200 status code
    case ServerError(statusCode: Int, error: NSError)
    
    // We got no data (0 bytes) back from the server
    case NoDataError
    
    // The server response can't be converted from JSON to a Dictionary
    case JSONSerializationError
    
    // The Argo decoding Failed
    case JSONMappingError(conversionError: DecodeError)
}
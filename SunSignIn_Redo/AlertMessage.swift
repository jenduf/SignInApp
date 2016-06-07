//
//  AlertMessage.swift
//  GolfMedia
//
//  Created by Jennifer Duffey on 5/8/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import Foundation

enum ButtonLayoutType: Int
{
    case Horizontal, Vertical
}

struct AlertMessage
{
    var title: String?
    var message: String?
    var buttons: [String]?
    var buttonLayoutType: ButtonLayoutType = .Horizontal
}
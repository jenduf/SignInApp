
//
//  AlertButton.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class AlertButton: UIButton
{
    var cornersToRound: UIRectCorner?
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BUTTON)
        
        self.titleLabel?.text = "BUTTON"
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func drawRect(rect: CGRect)
    {
        let rectangle2Path = UIBezierPath(roundedRect: CGRectMake(0, rect.size.height - Constants.Layout.ALERT_BUTTON_HEIGHT, rect.size.width / 2, Constants.Layout.ALERT_BUTTON_HEIGHT), byRoundingCorners: self.cornersToRound!, cornerRadii: CGSizeMake(Constants.Layout.CORNER_RADIUS, Constants.Layout.CORNER_RADIUS))
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)//Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BUTTON).CGColor)
        CGContextAddPath(context, rectangle2Path.CGPath)
        CGContextFillPath(context)
        CGContextRestoreGState(context)
    }*/
}
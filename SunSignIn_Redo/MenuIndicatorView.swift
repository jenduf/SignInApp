//
//  MenuIndicatorView.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class MenuIndicatorView: UIView
{

    var indicatorLayer: CAShapeLayer?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        
        // add indicator sublayer
        self.indicatorLayer = CAShapeLayer()
        
        self.layer.addSublayer(self.indicatorLayer!)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.indicatorLayer!.fillColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_INDICATOR_ACTIVE).CGColor
        self.indicatorLayer!.lineWidth = Constants.Layout.DIVIDER_HEIGHT
        
        let firstButton = (self.size.width * 0.12)
        
        let startX = (firstButton + Constants.Layout.VERTICAL_PADDING)
        
        if self.indicatorRect?.origin.x <= startX
        {
            self.indicatorRect = CGRect(x: startX, y: 0, width: self.bounds.width, height: Constants.Layout.DIVIDER_HEIGHT)//width: Constants.Layout.TOP_BUTTON_WIDTH, height: Constants.Layout.DIVIDER_HEIGHT)
        }
        
    }
    
    var indicatorRect: CGRect?
    {
        didSet
        {
           // self.indicatorLayer?.frame = self.indicatorRect!
            self.animateIndicator()
        }
    }
    
    func animateIndicator()
    {
        let newPath = UIBezierPath(rect: self.indicatorRect!).CGPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = Constants.ANIMATION_DURATION
        animation.fromValue = self.indicatorLayer?.path
        animation.toValue = newPath
        self.indicatorLayer?.path = newPath
        self.indicatorLayer?.addAnimation(animation, forKey: "path")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) 
    {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, UIColor.purpleColor().CGColor)
        CGContextFillRect(context, rect)
        CGContextRestoreGState(context)
        
        print("rect: \(rect) indicator: \(self.indicatorRect)")
        
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, Utils.UIColorFromRGB(Constants.COLOR_INDICATOR_ACTIVE).CGColor)
        CGContextFillRect(context, self.indicatorRect)
        CGContextRestoreGState(context)
    }*/
    

}

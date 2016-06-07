//
//  DrawingView.swift
//  FantasyStats
//
//  Created by Jennifer Duffey on 3/17/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol DrawingViewDelegate
{
    func drawingViewDidstart(drawingView: DrawingView)
    func drawingViewDidFinish(drawingView: DrawingView)
}


class DrawingView: UIView
{
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
    
    
    var delegate: DrawingViewDelegate?
    
    
    var lastPoint = CGPoint.zero
    
    var brushWidth: CGFloat = 10.0
    
    var opacity: CGFloat = 1.0
    
    var swiped: Bool = false
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint)
    {
        UIGraphicsBeginImageContext(self.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        self.tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        CGContextStrokePath(context)
        
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempImageView.alpha = opacity

        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.swiped = false
        
        if let touch = touches.first
        {
            self.lastPoint = touch.locationInView(self)
        }
     
        self.delegate?.drawingViewDidstart(self)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.swiped = true
        
        if let touch = touches.first
        {
            let currentPoint = touch.locationInView(self)
            self.drawLineFrom(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if !self.swiped
        {
            self.drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(self.mainImageView.frame.size)
        
        self.mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        self.tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.tempImageView.image = nil
        
        self.delegate?.drawingViewDidFinish(self)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

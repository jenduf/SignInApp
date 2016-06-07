//
//  UIView+Geometry.swift
//  GolfMedia
//
//  Created by Jennifer Duffey on 4/14/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

extension UIView
{
    var origin: CGPoint
    {
        get
        {
            return self.frame.origin
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.origin = newValue
            self.frame = newFrame
        }
    }
    
    var size: CGSize
    {
        get
        {
            return self.frame.size
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
    }
    
    var top: CGFloat
    {
        get
        {
            return self.frame.origin.y
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    
    var bottom: CGFloat
    {
        get
        {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.origin.y = newValue - self.frame.size.height
            self.frame = newFrame
        }
    }
    
    var left: CGFloat
    {
        get
        {
            return self.frame.origin.x
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    
    var right: CGFloat
    {
        get
        {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set
        {
            let delta = newValue - (self.frame.origin.x + self.frame.size.width)
            var newFrame: CGRect = self.frame
            newFrame.origin.x += delta
            self.frame = newFrame
        }
    }
    
    var width: CGFloat
    {
        get
        {
            return self.frame.size.width
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    
    var height: CGFloat
    {
        get
        {
            return self.frame.size.height
        }
        
        set
        {
            var newFrame: CGRect = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    
    func moveBy(delta: CGPoint)
    {
        var newCenter = self.center
        newCenter.x += delta.x
        newCenter.y += delta.y
        self.center = newCenter
    }
}

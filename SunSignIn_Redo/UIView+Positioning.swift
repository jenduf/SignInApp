//
//  UIView+Positioning.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

extension UIView
{
    func centerInRect(rect: CGRect)
    {
        self.center = CGPoint(x: rect.midX, y: rect.midY)
    }
    
    func centerInSuperview()
    {
        self.centerInRect((self.superview?.bounds)!)
    }
    
    func centerHorizontallyInRect(rect: CGRect)
    {
        self.center = CGPoint(x: rect.midX, y: self.center.y)
    }
    
    func centerHorizontallyInSuperview()
    {
        self.centerHorizontallyInRect(self.superview!.bounds)
    }

    func removeAllSubviewsFromView()
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
    }
    
}

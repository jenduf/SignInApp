//
//  GradientView.swift
//  FantasyStats
//
//  Created by Jennifer Duffey on 3/11/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class GradientView: UIView
{
    let gradientLayer = CAGradientLayer()
    
    var colors: [CGColor]?
    {
        didSet
        {
            self.gradientLayer.colors = colors
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.layoutGradientLayer()
    }
   
    /*
    override func didMoveToWindow()
    {
        super.didMoveToWindow()
        
        self.layer.addSublayer(self.gradientLayer)
    }
*/
    
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.gradientLayer.frame = self.layer.bounds
        
       // self.layoutGradientLayer()
        
      //  self.layer.cornerRadius = 2.0
      //  self.layer.masksToBounds = true
    }
    
    
    func layoutGradientLayer()
    {
        //self.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        //self.gradientLayer.endPoint = CGPoint(x: 0.85, y: 1.0)
        
        //self.gradientLayer.locations = [0, 0.95, 1]
        
       // self.gradientLayer.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        
        self.layer.addSublayer(self.gradientLayer)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

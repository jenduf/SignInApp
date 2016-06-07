//
//  LoginTextField.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class FormTextField: UITextField
{
    var borderLayer: CALayer = CALayer()
    
    override var bounds: CGRect
    {
        didSet
        {
            self.updateBorder()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.initBorder()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.exclusiveTouch = true
        
        self.initBorder()
    }
    
    func isValid() -> Bool
    {
        return !self.text!.isEmpty
    }
    
    func initBorder()
    {
        let width: CGFloat = 2.0
        self.borderLayer.borderColor = UIColor.darkGrayColor().CGColor
        self.borderLayer.frame = CGRect(x: 0, y: self.bounds.size.height - width, width: self.bounds.size.width, height: self.bounds.size.height)
        
        self.borderLayer.borderWidth = width
        
        self.layer.addSublayer(self.borderLayer)
        
        self.layer.masksToBounds = true
    }
    
    func updateBorder()
    {
        let width: CGFloat = 2.0
        self.borderLayer.borderColor = UIColor.darkGrayColor().CGColor
        self.borderLayer.frame = CGRect(x: 0, y: self.bounds.height - width, width: self.bounds.width, height: self.bounds.height)
    }
    
    override func becomeFirstResponder() -> Bool
    {
        self.borderLayer.borderColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_TEXTFIELD_ACTIVE).CGColor
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool
    {
        self.borderLayer.borderColor = UIColor.darkGrayColor().CGColor
        return super.resignFirstResponder()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

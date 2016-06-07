//
//  DropdownButton.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class DropdownButton: UIButton
{
    var dropdownImageView: UIImageView?
    
    var prompt: String = ""
    {
        didSet
        {
            self.setTitle(prompt, forState: UIControlState.Normal)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        let dropdownImage = UIImage(named: Constants.Images.IMAGE_DROPDOWN)
        self.dropdownImageView = UIImageView(image: dropdownImage)
        self.addSubview(self.dropdownImageView!)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if self.dropdownImageView != nil
        {
            self.dropdownImageView!.frame = CGRect(origin: CGPoint(x: self.frame.size.width - self.dropdownImageView!.size.width - Constants.Layout.TEXT_FIELD_PADDING, y: (self.frame.height - self.dropdownImageView!.frame.height) / 2), size: self.dropdownImageView!.size)
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

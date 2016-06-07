//
//  TopButtonView.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class TopButtonView: UIView
{
    @IBOutlet var buttonImage: UIButton!
    @IBOutlet var buttonText: UILabel!
    
    func setButtonSelected(selected: Bool)
    {
        if selected == true
        {
            self.buttonText.textColor = UIColor.whiteColor()
        }
        else
        {
            self.buttonText.textColor = UIColor.lightGrayColor()
        }
        
        self.buttonImage.selected = selected
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

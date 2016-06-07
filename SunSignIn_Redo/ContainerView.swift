//
//  ContainerView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol ContainerViewDelegate
{
    func containerViewDidRequestLogin(user: String, pass: String)
    func containerViewDidRequestForgotPassword(user: String)
}

class ContainerView: UIView
{
    var delegate: ContainerViewDelegate?
    

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.layer.cornerRadius = Constants.Layout.CORNER_RADIUS
        
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  LoginInputView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class LoginInputView: UIView
{
    @IBOutlet var userTextField: FormTextField!
    @IBOutlet var passwordTextField: FormTextField!
    @IBOutlet var loginButton: UIButton!
    
    /*
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.userTextField = LoginTextField(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width - (Constants.CONTAINER_PADDING * 2), height: Constants.TEXT_FIELD_HEIGHT)))
        self.addSubview(self.userTextField!)
        
        self.passwordTextField = LoginTextField(frame: CGRect(origin: CGPoint(x: 0, y: self.userTextField!.bottom), size: CGSize(width: frame.width - (Constants.CONTAINER_PADDING * 2), height: Constants.TEXT_FIELD_HEIGHT)))
        self.addSubview(self.passwordTextField!)
        
        self.loginButton = UIButton(type: UIButtonType.Custom)
        self.loginButton?.setTitle("Login", forState: UIControlState.Normal)
        self.loginButton?.addTarget(self, action: #selector(LoginInputView.login(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.loginButton!)
    }*/
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    @IBAction func login(sender: AnyObject)
    {
       // self.delegate?.containerViewDidRequestLogin(self.userTextField!.text!, pass: self.passwordTextField!.text!)
        
    }
    
    @IBAction func forgotPassword(sender: AnyObject)
    {
        //self.delegate?.containerViewDidRequestForgotPassword(self.userTextField!.text!)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

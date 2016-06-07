//
//  ViewController.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/28/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController
{
    @IBOutlet var loginInputView: LoginInputView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.loginTapped(_:)))
       // tapGesture.delegate = self
       // self.loginButton.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func login(sender: AnyObject)
    {
        if let user = self.loginInputView.userTextField.text, let pass = self.loginInputView.passwordTextField.text
        {
            APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_LOGIN, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user, pass ])
            { (data, error) in
                if let userDict = data!["data"] as? NSDictionary
                {
                    let user = User(json: userDict)
                    if user.userID != nil
                    {
                        User.currentUser = user
                        self.mainViewController?.showScreen(NavScreen.Program, size: self.mainViewController!.mainScrollView!.size)
                    }
                }
            }
        }
        else
        {
            print("NEED USER NAME AND PASSWORD")
        }
    }
    
    @IBAction func forgotPassword(sender: AnyObject)
    {
        if let user = self.loginInputView.userTextField.text
        {
            APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_FORGOT_PASSWORD, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user ])
            { (data, error) in
            
            }
        }
        else
        {
            print("NEED USER NAME")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
extension LoginViewController: UIGestureRecognizerDelegate
{
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}*/


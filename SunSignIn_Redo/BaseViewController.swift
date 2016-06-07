//
//  BaseViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    var mainViewController: MainViewController?
    
    @IBOutlet var formScrollView: UIScrollView!
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadData()
    {
        // override
    }
    
    func saveData()
    {
        // override
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardDidShow(note: NSNotification)
    {
        let info : NSDictionary = note.userInfo!
        let kbSize = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue as CGRect!).size
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        
        self.formScrollView.contentInset = contentInsets
    }
    
    func keyboardWillHide(note: NSNotification)
    {
        let contentInsets = UIEdgeInsetsZero
        
        self.formScrollView.contentInset = contentInsets
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

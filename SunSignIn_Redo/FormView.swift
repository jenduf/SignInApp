//
//  FormView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/2/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class FormView: UIView, UITextFieldDelegate
{
    @IBOutlet var formFields: [FormTextField]!
    
    
    var user: User?
    {
        didSet
        {
            self.populateFormFields()
        }
    }
    
    var event: EventItem?
    {
        didSet
        {
            self.populateFormFields()
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func populateFormFields()
    {
        
    }

    func validateFormFields() -> Bool
    {
        for form in self.formFields
        {
            if form.hidden == false
            {
                if form.isValid() == false
                {
                    return false
                }
            }
        }
        
        return true
    }

    
    // MARK: UITextField Delegate Methods
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}

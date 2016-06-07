//
//  ProgramInfoView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ProgramInfoView: FormView
{
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var userName: FormTextField!
    @IBOutlet var title: FormTextField!
    @IBOutlet var company: FormTextField!
    @IBOutlet var department: FormTextField!
    @IBOutlet var practiceName: FormTextField!
    @IBOutlet var city: FormTextField!
    @IBOutlet var merchant: FormTextField!
    @IBOutlet var mealCost: FormTextField!
    @IBOutlet var receiptNumber: FormTextField!
    @IBOutlet var receiptButton: UIButton!
    @IBOutlet var stateTextField: DropDownText!
    @IBOutlet var programTypeTextField: DropDownText!
    @IBOutlet var productsTextField: DropDownText!
    @IBOutlet var dateAndTimeTextField: DropDownText!
    

    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func populateFormFields()
    {
        if self.user != nil
        {
            self.logoImageView.loadFromURLWithCallback(NSURL(string: self.user!.companyDetails!.logo!)!, callback:
            { (image) in
                self.logoImageView.image = image
            })
            
            self.userName.text = self.user!.userName
            self.title.text = self.user!.getTitleString()
            self.company.text = self.user!.companyDetails?.companyName
            self.department.text = self.user?.getDepartmentString()
            
            self.productsTextField.dropdownData = self.user!.products
            self.stateTextField.dropdownData = State.getStatesFromPlist()
            self.programTypeTextField.dropdownData = ProgramType.getProgramTypes()
        }
        
        if self.event != nil
        {
            self.practiceName.text = self.event?.practice
            self.city.text = self.event?.city
            self.stateTextField.text = self.event?.state
            self.programTypeTextField.text = self.event?.type
            self.merchant.text = self.event?.merchantName
            self.mealCost.text = self.event?.mealCost
            self.receiptNumber.text = self.event?.receiptNumber
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

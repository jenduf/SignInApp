//
//  RegistrationView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class RegistrationView: FormView
{
    @IBOutlet var firstName: FormTextField!
    @IBOutlet var lastName: FormTextField!
    @IBOutlet var title: DropDownText!
    @IBOutlet var city: FormTextField!
    @IBOutlet var state: DropDownText!
   

    var participant: Participant?
    {
        didSet
        {
            self.populateFields()
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    
    }
    
    func populateFields()
    {
        self.firstName.text = self.participant?.firstName
        self.lastName.text = self.participant?.lastName
        self.title.text = self.participant?.title
        self.city.text = self.participant?.city
        self.state.text = self.participant?.state?.itemID
        
        self.state.dropdownData = State.getStatesFromPlist()
        
        self.title.dropdownData = ParticipantTitle.getDataItems()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

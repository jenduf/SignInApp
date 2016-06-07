//
//  RegistrationHeaderView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/31/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class EventHeaderView: UIView
{
    @IBOutlet var participants: UILabel!
    @IBOutlet var hcps: UILabel!
    @IBOutlet var staff: UILabel!
    @IBOutlet var declines: UILabel!
    
    var participantCount: ParticipantCount?
    {
        didSet
        {
            self.populateHeader()
        }
        
    }
    
    func populateHeader()
    {
        if self.participantCount != nil
        {
            self.participants.text = "\(self.participantCount!.totalParticipants)"
            self.hcps.text = "\(self.participantCount!.totalHCPs)"
            self.staff.text = "\(self.participantCount!.totalStaff)"
            self.declines.text = "\(self.participantCount!.totalDenied)"
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        //self.participants.text = "0"
        //self.hcps.text = "0"
        //self.staff.text = "0"
        //self.declines.text = "0"
    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

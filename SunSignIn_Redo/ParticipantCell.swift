//
//  ParticipantCell.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/31/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ParticipantCell: UITableViewCell
{
    @IBOutlet var name: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var state: UILabel!
    @IBOutlet var npi: UITextField!
    @IBOutlet var signature: UIImageView!
    @IBOutlet var meal: UILabel!
    
    
    var participant: Participant?
    {
        didSet
        {
            self.setUpCell()
        }
    }
    
    func setUpCell()
    {
        if self.participant != nil && self.participant?.firstName != nil
        {
            self.name.text = "\(self.participant!.firstName!) \(self.participant!.lastName!)"
            self.title.text = self.participant?.title
            self.state.text = self.participant?.state?.itemName
            self.signature.image = self.participant?.signature
            self.npi.text = self.participant?.npiObject?.npiNumber
            self.meal.text = self.participant?.getMealString()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

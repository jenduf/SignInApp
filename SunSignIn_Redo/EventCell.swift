//
//  EventCell.swift
//  Sign In
//
//  Created by Jennifer Duffey on 5/26/16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell
{
    var eventItem: EventItem?
    {
        didSet
        {
            self.setUpCell()
        }
    }
    
    func setUpCell()
    {
        self.textLabel?.text = eventItem?.eventID
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

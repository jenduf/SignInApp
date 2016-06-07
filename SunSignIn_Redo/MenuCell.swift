//
//  MenuCell.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell
{
    @IBOutlet var menuTitle: UILabel!
    @IBOutlet var menuImage: UIImageView!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        if selected == true
        {
            self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        }
        else
        {
            self.backgroundColor = UIColor.clearColor()
        }
    }

}

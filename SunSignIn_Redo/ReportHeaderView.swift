//
//  ReportHeaderView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ReportHeaderView: UIView
{
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var company: UILabel!
    @IBOutlet var department: UILabel!
    @IBOutlet var product: UILabel!
    @IBOutlet var date: UILabel!
    
    @IBOutlet var practice: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var program: UILabel!
    @IBOutlet var merchant: UILabel!
    @IBOutlet var receipt: UILabel!
    @IBOutlet var mealCost: UILabel!
    @IBOutlet var perPerson: UILabel!

    var event: EventItem?
    {
        didSet
        {
            if event?.eventID != nil
            {
                self.populateHeader()
            }
        }
    }
    
    var user: User?
    {
        didSet
        {
            self.logoImageView.loadFromURLWithCallback(NSURL(string: self.user!.companyDetails!.logo!)!, callback:
            { (image) in
                    self.logoImageView.image = image
            })
            
            self.name.text = self.user!.userName
            self.title.text = self.user!.getTitleString()
            self.company.text = self.user!.companyDetails?.companyName
            self.department.text = self.user?.getDepartmentString()
        }
    }
    
    func populateHeader()
    {
        self.product.text = self.event?.products
        self.date.text = self.event?.convertDate(self.event!.eventDate!)
        self.practice.text = self.event?.practice
        self.location.text = "\(self.event!.city), \(self.event!.state)"
        self.program.text = self.event?.type
        self.merchant.text = self.event?.merchantName
        self.receipt.text = self.event?.receiptNumber
        self.mealCost.text = self.event?.mealCost
        self.perPerson.text = self.event?.getCostPerPerson()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

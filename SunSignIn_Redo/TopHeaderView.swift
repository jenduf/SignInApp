//
//  TopHeaderView.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/29/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

protocol TopHeaderViewDelegate
{
    func topHeaderViewDidRequestScreen(navScreen: NavScreen)
}

class TopHeaderView: UIView
{
    @IBOutlet var menuIndicator: MenuIndicatorView!
    
    @IBOutlet var menuButtons: [TopButtonView]!
    
    
    var headerViewDelegate: TopHeaderViewDelegate?
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        for button in self.menuButtons
        {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopHeaderView.headerButtonSelected(_:)))
            button.addGestureRecognizer(tapRecognizer)
        }
    }
    
    @IBAction func headerButtonSelected(recognizer: UITapGestureRecognizer)
    {
        let buttonView = recognizer.view as! TopButtonView
        
        let navScreen = NavScreen(rawValue: buttonView.tag)
       
        /*
        for button in self.menuButtons
        {
            button.setButtonSelected(false)
        }
        
        buttonView.setButtonSelected(true)
        
        print("button frame: \(buttonView.frame)")
        
        self.menuIndicator.indicatorRect = CGRect(x: buttonView.frame.origin.x, y: 0, width: buttonView.frame.width, height: Constants.Layout.DIVIDER_HEIGHT)
        */
    
        self.headerViewDelegate?.topHeaderViewDidRequestScreen(navScreen!)
    }
    
    func setNavItemSelected(screen: NavScreen, size: CGSize)
    {
        for button in self.menuButtons
        {
            if button.tag == screen.rawValue
            {
                button.setButtonSelected(true)
                
                let firstButton = size.width * 0.12
                
                let startX = firstButton + Constants.Layout.VERTICAL_PADDING
                
                let allWidth = size.width - startX
                
                let newWidth =  size.width * 0.17
                
                let newX = startX + (CGFloat(button.tag - 1) * newWidth) + Constants.Layout.SIDE_PADDING
                
                self.menuIndicator.indicatorRect = CGRect(x: newX, y: 0, width: newWidth, height: Constants.Layout.DIVIDER_HEIGHT) //(button as TopButtonView).frame.width, height: Constants.Layout.DIVIDER_HEIGHT)
                
                //self.menuIndicator.width = button.width
            }
            else
            {
                button.setButtonSelected(false)
            }
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

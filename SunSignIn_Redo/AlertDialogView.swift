//
//  AlertDialogView.swift
//  GolfMedia
//
//  Created by Jennifer Duffey on 5/7/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class AlertDialogView: UIView
{
    var closeButton: UIButton!
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var actionButtons = [UIButton]()
    
    
    var alertMessage: AlertMessage?
    
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
    }
    
    
    override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        
        if self.superview != nil
        {
            self.centerInSuperview()
        }
    }
    
    
    
    init(message: AlertMessage)
    {
        //let screenSize = UIScreen.mainScreen().bounds
        let alertRect = CGRect(origin: CGPoint.zero, size: CGSize(width: Constants.Layout.ALERT_VIEW_WIDTH, height: Constants.Layout.ALERT_VIEW_HEIGHT)) //screenSize.width - (Constants.Layout.SIDE_PADDING * 2), height: Constants.Layout.ALERT_MESSAGE_DEFAULT_HEIGHT))
        
        super.init(frame: alertRect)
        
        self.clipsToBounds = true
        
        self.backgroundColor = UIColor.clearColor()
        
        self.alertMessage = message
        
        self.setUpElements()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpElements()
    {
      /*  let closeButtonImage = UIImage(named: Constants.IMAGE_CLOSE_BUTTON)
        self.closeButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: closeButtonImage!.size))
        self.closeButton.setImage(closeButtonImage, forState: UIControlState.Normal)
        self.closeButton.addTarget(self, action: #selector(AlertDialogView.close(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.closeButton)
        
        self.closeButton.right = frame.maxX
        self.closeButton.top = frame.minY
        */
        let estimatedWidth = self.bounds.width - (90)
        
        if self.alertMessage?.title != nil
        {
            self.titleLabel = UILabel(frame: CGRect.zero)
          //  self.titleLabel.font = UIFont(name: Constants.FONT_FAMILY_DOSIS_BOLD, size: Constants.FONT_SIZE_HEADER_4)
            self.titleLabel.textColor = UIColor.whiteColor()
            self.titleLabel.textAlignment = .Center
            self.titleLabel.lineBreakMode = .ByWordWrapping
            self.titleLabel.numberOfLines = 0
            self.titleLabel.preferredMaxLayoutWidth = estimatedWidth
            self.addSubview(self.titleLabel)
            
            self.titleLabel.text = self.alertMessage?.title
        }
        
        if self.alertMessage?.message != nil
        {
            self.messageLabel = UILabel(frame: self.frame.insetBy(dx: Constants.Layout.SIDE_PADDING, dy: 0))
          //  self.messageLabel.font = UIFont(name: Constants.FONT_FAMILY_BOXCUTTER_BOLD, size: Constants.FONT_SIZE_HEADER_4)
            self.messageLabel.textColor = UIColor.whiteColor()
            self.messageLabel.textAlignment = .Center
            self.messageLabel.lineBreakMode = .ByWordWrapping
            self.messageLabel.numberOfLines = 0
            self.messageLabel.preferredMaxLayoutWidth = estimatedWidth
            self.addSubview(self.messageLabel)
        
            self.messageLabel.text = self.alertMessage?.message
            
          //  self.messageLabel.sizeToFit()
        }
        
        if let buttons = self.alertMessage?.buttons
        {
            _ = 0
            
            for button in buttons
            {
               // let actionButton = AlertButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.width / CGFloat(buttons.count), height: Constants.Layout.ALERT_VIEW_HEIGHT)))
                
                let newButton = UIButton(type: .Custom)
                newButton.setTitle(button, forState: UIControlState.Normal)
                newButton.setTitleColor(Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BACKGROUND), forState: .Normal)
                newButton.backgroundColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BUTTON)
                newButton.tag = 0
                self.actionButtons.append(newButton)
            
                //actionButton.setTitleColor(Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BACKGROUND), forState: .Normal)
                //actionButton.setTitle(button, forState: .Normal)
               // actionButton.backgroundColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BUTTON)
                //actionButton.titleLabel?.font = UIFont(name: Constants.FONT_FAMILY_DOSIS_BOLD , size: Constants.FONT_SIZE_DIALOG_BUTTON)
               // self.addSubview(actionButton)
                
                //                self.actionButtons.append(actionButton)
            }
        }
        
        self.layoutElements()
    }
    
    func layoutElements()
    {
        var newHeight: CGFloat = 0
        
        if self.alertMessage?.title != nil
        {
            _ = self.titleLabel.height//positionAndResizeInFrame(self.frame)
          //  newHeight += titleHeight
        }
        
        if self.alertMessage?.message != nil
        {
            let messageHeight = self.messageLabel.height//positionAndResizeInFrame(self.frame)
            newHeight += messageHeight
        }
        
        let (_, remainder) = self.bounds.divide((Constants.Layout.ALERT_BUTTON_HEIGHT), fromEdge: CGRectEdge.MaxYEdge)
        self.messageLabel.centerInRect(remainder)
        
        
        if self.alertMessage?.buttons != nil
        {
          //  newHeight += Constants.Layout.SIDE_PADDING
        }
        
       // var newFrame = self.bounds
       // newFrame.size.height += newHeight
       // self.frame = newFrame
        
        self.titleLabel.centerHorizontallyInSuperview()
      //  self.messageLabel.centerHorizontallyInSuperview()
        
        self.titleLabel.bottom = (self.bounds.midY - Constants.Layout.SMALL_PADDING)
       // self.messageLabel.top = (self.bounds.midY + Constants.Layout.SMALL_PADDING)
        
        
        if self.actionButtons.isEmpty == false
        {
            var buttonLeft: CGFloat = 0.0
            
            var remainder: CGFloat = 0.0
            
            let allButtons = self.actionButtons.count
            
            for i in 0 ..< allButtons
            {
                let button = self.actionButtons[i] as UIButton
                
                let buttonWidth = self.bounds.size.width / CGFloat(self.actionButtons.count)
                
                let remainder = self.bounds.size.width % CGFloat(self.actionButtons.count)
                
                var buttonSize = CGSize(width: buttonWidth - Constants.Layout.ALERT_SEPARATOR, height: Constants.Layout.ALERT_BUTTON_HEIGHT)
                
                if button == self.actionButtons.last
                {
                    buttonSize.width += remainder
                }
                
                button.frame = CGRect(origin: CGPoint(x: buttonLeft, y: CGFloat(self.bounds.size.height - Constants.Layout.ALERT_BUTTON_HEIGHT)), size: buttonSize)
                
                buttonLeft += (buttonWidth + Constants.Layout.ALERT_SEPARATOR)
                
                self.addSubview(button)
                
                button.addTarget(self, action: #selector(AlertDialogView.clickedAlertButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
               // if buttonLeft == 0.0
               // {
                 //   actionButton.cornersToRound = UIRectCorner.BottomLeft
                //}
                //else if buttonLeft >= (self.width / CGFloat(2.0))
                //{
                  //  actionButton.cornersToRound = UIRectCorner.BottomRight
                //}
                
               // actionButton.origin = CGPoint(x: buttonLeft, y: self.bounds.size.height - Constants.Layout.ALERT_BUTTON_HEIGHT)
               // actionButton.bottom = (self.height - Constants.Layout.VERTICAL_PADDING)
                
               // buttonLeft += actionButton.width
            }
        }
        
       // self.setNeedsDisplay()
    }
    
    
    
    func showInView(view: UIView)
    {
        //let labelRect = self.frame.insetBy(dx: Constants.SIDE_PADDING, dy: Constants.BOTTOM_PADDING)
        
        
        
        view.addSubview(self)
    }

    func close(sender: AnyObject)
    {
        self.alertMessage = nil
        self.removeFromSuperview()
    }
    
    func clickedAlertButton(sender: AnyObject)
    {
        self.removeFromSuperview()
    }
    
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext)
    {
        super.drawLayer(layer, inContext: ctx)
        
        layer.cornerRadius = Constants.Layout.CORNER_RADIUS
        layer.masksToBounds = true
        layer.backgroundColor = Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BACKGROUND).CGColor
    }
    
    override func drawRect(rect: CGRect)
    {
        
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect)
     {
        let (slice, _) = self.bounds.divide((Constants.Layout.ALERT_BUTTON_HEIGHT + Constants.Layout.VERTICAL_PADDING), fromEdge: CGRectEdge.MaxYEdge)
        
       // let backgroundRect = CGRect(origin: CGPoint(x: 0, y: Constants.Layout.SIDE_PADDING), size: CGSize(width: rect.size.width - Constants.Layout.VERTICAL_PADDING, height: rect.size.height - Constants.Layout.VERTICAL_PADDING))
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.Layout.CORNER_RADIUS)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BACKGROUND).CGColor)
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        //CGContextFillRect(context, backgroundRect)
        CGContextRestoreGState(context)
        
        let rectangle2Path = UIBezierPath(roundedRect: slice.insetBy(dx: 0, dy: Constants.Layout.VERTICAL_PADDING), byRoundingCorners: [ UIRectCorner.BottomLeft, UIRectCorner.BottomRight], cornerRadii: CGSizeMake(Constants.Layout.CORNER_RADIUS, Constants.Layout.CORNER_RADIUS))
        
       // let remainderPath = UIBezierPath(roundedRect: slice, cornerRadius: Constants.Layout.CORNER_RADIUS)
        
      /*  CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, Utils.UIColorFromRGB(Constants.Colors.COLOR_ALERT_BUTTON).CGColor)
        CGContextAddPath(context, rectangle2Path.CGPath)
        CGContextFillPath(context)
        CGContextRestoreGState(context)*/
     }*/
    
}
//
//  DropdownView.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/27/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class DropdownView: UIView
{
    var dropdownPicker: UIPickerView?
    var datePicker: UIDatePicker?
    
    
    var dropdownData = [DataItem]()
    {
        didSet
        {
            self.showPicker()
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.width = self.bounds.width
        
       // self.dropdownPicker?.width = self.bounds.width
        
        print("DROPDOWN FRAME: \(self.bounds), PICKER FRAME: \(self.dropdownPicker?.bounds)")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        print("DROPDOWN FRAME: \(frame)")
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        
        self.clipsToBounds = true
        
        self.dropdownPicker = UIPickerView(frame: CGRect(origin: CGPoint(x: 2, y: -frame.size.height), size: CGSize(width: frame.size.width - 2, height: frame.size.height - 2)))
        self.dropdownPicker?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(1.0)
        self.dropdownPicker?.showsSelectionIndicator = false
        
        self.dropdownPicker?.delegate = self
        self.dropdownPicker?.dataSource = self
        
        self.addSubview(self.dropdownPicker!)
        
        self.datePicker = UIDatePicker(frame: CGRect(origin: CGPoint(x: 2, y: -frame.size.height), size: CGSize(width: frame.size.width - 2, height: frame.size.height - 2)))
        self.datePicker?.backgroundColor = UIColor.whiteColor()
        self.datePicker?.datePickerMode = UIDatePickerMode.DateAndTime
        self.datePicker?.minimumDate = NSDate()
        
        self.addSubview(self.datePicker!)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    func showPicker()
    {
        self.hidden = false
        
        UIView.animateWithDuration(0.2, animations:
        {
            self.dropdownPicker!.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
            //self.dropdownPicker!.size
            //self.dropdownPicker!.transform = CGAffineTransformTranslate(self.dropdownPicker!.transform, 0, self.dropdownPicker!.frame.height)
        })
        { (finished) in
            
            self.dropdownPicker!.reloadAllComponents()
            
            print("DROPDOWN FRAME: \(self.frame), PICKER FRAME: \(self.dropdownPicker!.frame)")
        }
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations:
        {
            self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        })
        { (complete) in
            
        }
    }
    
    func hidePicker()
    {
        UIView.animateWithDuration(0.2, animations:
        {
            self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        })
        { (finished) in
            
            print("ROW SIZE FOR COMPONENT \(self.dropdownPicker?.rowSizeForComponent(0))")
            
            //self.dropdownPicker.reloadAllComponents()
        }
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations:
        {
            self.dropdownPicker!.frame = CGRect(origin: CGPoint(x: 0, y: -self.dropdownPicker!.frame.height), size: self.frame.size)
            
            //self.dropdownPicker!.transform = CGAffineTransformTranslate(self.dropdownPicker!.transform, 0, -self.dropdownPicker!.frame.height)
        })
        { (complete) in
            self.hidden = true
            
            print("DROPDOWN FRAME: \(self.frame), PICKER FRAME: \(self.dropdownPicker?.frame)")
        }
    }
    
    func showDatePicker()
    {
        self.hidden = false
        
        self.datePicker?.addTarget(self, action: #selector(DropdownView.datePickerDidChange), forControlEvents: UIControlEvents.ValueChanged)
        
        UIView.animateWithDuration(0.2, animations:
        {
            self.datePicker!.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        })
        { (finished) in
            
            //self.datePicker!.reloadAllComponents()
        }
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations:
        {
            self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        })
        { (complete) in
            
            print("DATE PICKER FRAME: \(self.datePicker!.frame)")
            
        }
    }
    
    func hideDatePicker()
    {
        UIView.animateWithDuration(0.2, animations:
        {
            self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        })
        { (finished) in
            
            
        }
        
        UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations:
        {
            self.datePicker!.frame = CGRect(origin: CGPoint(x: 0, y: -self.datePicker!.frame.height), size: self.frame.size)
        })
        { (complete) in
            self.hidden = true
        }
    }
    
    func datePickerDidChange()
    {
       // let newDate = self.datePicker?.date
        self.hideDatePicker()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension DropdownView: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.dropdownData.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let dropdownItem = self.dropdownData[row] as DataItem
        
        let backgroundView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.frame.size.width, height: Constants.Layout.DROPDOWN_ROW_HEIGHT)))
       // backgroundView.backgroundColor = UIColor.blueColor()
        
       // let image = UIImage(named: Constants.Images.IMAGE_DROPDOWN_BACKGROUND)
       // let imageView = UIImageView(image: image)
        
       // imageView.frame = CGRect(origin: CGPoint.zero, size: image!.size)
        
       // backgroundView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: backgroundView.frame.size))
        label.font = UIFont(name: "Helvetica-Neue", size: 12.0)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        label.shadowColor = UIColor.whiteColor()
        
        label.text = dropdownItem.itemName
        
        backgroundView.addSubview(label)
        
       // label.sizeToFit()
        
        return backgroundView
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return Constants.Layout.DROPDOWN_ROW_HEIGHT
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return self.bounds.size.width
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
       // let dropdownItem = self.dropdownData[row] as DataItem
        
        self.hidePicker()
    }
}

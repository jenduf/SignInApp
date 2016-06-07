//
//  DropDownText.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 6/1/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class DropDownText: FormTextField
{
    lazy var picker: UIPickerView =
        {
            let newPicker = UIPickerView(frame: CGRect.zero)
            newPicker.showsSelectionIndicator = true
            newPicker.dataSource = self
            newPicker.delegate = self
            return newPicker
    }()
    
    lazy var datePicker: UIDatePicker =
        {
            let newPicker = UIDatePicker(frame: CGRect.zero)
            newPicker.addTarget(self, action: #selector(DropDownText.datePickerDidChange), forControlEvents: UIControlEvents.ValueChanged)
           // newPicker.minimumDate = NSDate()
            return newPicker
    }()
    
    var dropdownData: [DataItem]?
    {
        didSet
        {
            self.picker.reloadAllComponents()
        }
    }
    
    var selectedItem: DataItem?
    
    /*
     override func becomeFirstResponder() -> Bool
     {
     super.becomeFirstResponder()
     
     self.getInputView()
     
     return true
     }
     */
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.getInputView()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    
    func datePickerDidChange()
    {
        let formatter = NSDateFormatter()
        //formatter.dateFormat = "MMMM d, yyyy h:mm a"
        formatter.dateFormat = "MM/dd/yy h:mm a"
        self.text = formatter.stringFromDate(self.datePicker.date)
        
        self.resignFirstResponder()
    }
    
    func getInputView()
    {
        if self.tag == 0
        {
            self.inputView = self.picker
            
            //  self.picker.reloadAllComponents()
        }
        else
        {
            self.inputView = self.datePicker
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

extension DropDownText: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.dropdownData!.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let dropdownItem = self.dropdownData![row]
        
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
        
        //   self.hidePicker()
        
        self.selectedItem = self.dropdownData![row]
        
        self.text = self.selectedItem!.itemName
        
        self.resignFirstResponder()
    }

}

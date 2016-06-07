//
//  ProgramInfoViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ProgramInfoViewController: BaseViewController
{
    @IBOutlet var programInfoView: ProgramInfoView!
    
   // var dropdownView: DropdownView?
    
    var receiptImage: UIImage?
    
    lazy var imagePicker: UIImagePickerController =
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
      //  print("BUTTON FRAME: \(self.programInfoView.productsButton.frame.width)")
        
      //  self.dropdownView?.frame = CGRect(origin: CGPoint.zero, size:CGSize(width: self.programInfoView.productsButton.frame.size.width, height: self.dropdownView!.height))
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        
     //   self.dropdownView = DropdownView(frame: CGRect(origin: CGPoint(x: self.programInfoView.productsButton.frame.origin.x, y: self.programInfoView.productsButton.bottom), size: CGSize(width: self.programInfoView.productsButton.frame.size.width, height: Constants.Layout.DROPDOWN_VIEW_HEIGHT)))
        
        //self.programInfoView.addSubview(self.dropdownView!)
        
       // self.dropdownView!.hidden = true

        //self.loadData()
    }
    
    override func loadData()
    {
        self.programInfoView.event = EventItem.currentEventItem
        
        let user = User.currentUser
        
        // MARK: Load Company Details
        APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_GET_COMPANY_DETAILS, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ /*User.currentUser!.companyID!, User.currentUser!.departmentID!, User.currentUser!.title!*/ ])
        { (data, error) in
            
            if let companyArray = data!["data"] as? NSArray
            {
                print("COMPANY DETAILS: \(companyArray)")
                
                for row in companyArray
                {
                    if let rowDict = row as? NSDictionary
                    {
                        if let companyID = rowDict["id"] as? String
                        {
                            let userCompanyID = user!.companyID
                            
                            if userCompanyID == companyID
                            {
                                let companyDetails = CompanyDetails(json: rowDict)
                                
                                user!.companyDetails = companyDetails
                                
                                break
                            }
                        }
                    }
                }
                
                // MARK: Load Titles
                APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_GET_TITLES, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ /*User.currentUser!.companyID!, User.currentUser!.departmentID!, User.currentUser!.title!*/ ])
                { (data, error) in
                    
                    if let titleDictionary = data as? NSDictionary
                    {
                        for key in titleDictionary.allKeys
                        {
                            let titleValue = titleDictionary[key as! String] as! String
                            
                            let titleData = DataItem(itemID: key as! String, itemName: titleValue)
                            
                            user!.titles.append(titleData)
                        }
                    }
                    
                    // MARK: Load Departments
                    APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_GET_DEPARTMENTS, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user!.companyID!/*, User.currentUser!.departmentID!, User.currentUser!.title!*/ ])
                    { (data, error) in
                        
                        if let departmentDictionary = data as? NSDictionary
                        {
                            for key in departmentDictionary.allKeys
                            {
                                let departmentValue = departmentDictionary[key as! String] as! String
                                
                                let departmentData = DataItem(itemID: key as! String, itemName: departmentValue)
                                
                                user!.departments.append(departmentData)
                            }
                        }
                        
                        // MARK: Load Products
                        APIManager.sharedManager.getAPIRequest(Constants.APIEndpoints.API_ENDPOINT_GET_PRODUCTS, method: Constants.HTTPRequestMethods.HTTP_GET, parameters: [ user!.companyID!, user!.departmentID!/*, User.currentUser!.title!*/ ])
                        { (data, error) in
                            
                            if let productDictionary = data as? NSDictionary
                            {
                                for key in productDictionary.allKeys
                                {
                                    let productValue = productDictionary[key as! String] as! String
                                    
                                    let productData = DataItem(itemID: key as! String, itemName: productValue)
                                    
                                    user!.products.append(productData)
                                }
                            }
                            
                            self.programInfoView.user = user
                            
                            User.currentUser = user
                        }
                    }
                }
            }
        }
    }

    override func saveData()
    {
        let event = EventItem()
        event.practice = self.programInfoView.practiceName.text
        event.city = self.programInfoView.city.text
        event.type = self.programInfoView.programTypeTextField.text
        event.state = self.programInfoView.stateTextField.text
        event.merchantName = self.programInfoView.merchant.text
        event.mealCost = self.programInfoView.mealCost.text
        event.receiptNumber = self.programInfoView.receiptNumber.text
        event.receiptImage = self.receiptImage
        EventItem.currentEventItem = event
    }
    
/*
    @IBAction func showProducts(sender: AnyObject)
    {
        let user = User.currentUser
        
        //self.dropdownView?.frame = CGRect(origin: CGPoint(x: self.programInfoView.productsButton.frame.origin.x, y: self.programInfoView.productsButton.bottom), size: CGSize(width: self.programInfoView.productsButton.frame.size.width, height: Constants.Layout.DROPDOWN_VIEW_HEIGHT))
        
        self.dropdownView!.dropdownData = user!.products
    }
    
    @IBAction func showDates(sender: AnyObject)
    {
        //self.dropdownView?.frame = CGRect(origin: CGPoint(x: self.programInfoView.dateAndTimeButton.frame.origin.x, y: self.programInfoView.dateAndTimeButton.bottom), size: CGSize(width: self.programInfoView.dateAndTimeButton.frame.size.width, height: Constants.Layout.DROPDOWN_VIEW_HEIGHT))
        
        self.dropdownView?.showDatePicker()
    }
    
    @IBAction func showStates(sender: AnyObject)
    {
        //self.dropdownView?.frame = CGRect(origin: CGPoint(x: self.programInfoView.stateButton.frame.origin.x, y: self.programInfoView.stateButton.bottom), size: CGSize(width: self.programInfoView.stateButton.frame.size.width, height: Constants.Layout.DROPDOWN_VIEW_HEIGHT))
        
        let state = DataItem(itemID: "0", itemName: "Alabama")
        let state1 = DataItem(itemID: "1", itemName: "Alaska")
        let state2 = DataItem(itemID: "2", itemName: "Arizona")
        let state3 = DataItem(itemID: "3", itemName: "Arkansas")
        
        let dropDownData = [ state, state1, state2, state3 ]
        
        self.dropdownView?.dropdownData = dropDownData
    }
    
    @IBAction func showProgramTypes(sender: AnyObject)
    {
      //  self.dropdownView?.frame = CGRect(origin: CGPoint(x: self.programInfoView.programTypeButton.frame.origin.x, y: self.programInfoView.programTypeButton.bottom), size: CGSize(width: self.programInfoView.programTypeButton.frame.size.width, height: Constants.Layout.DROPDOWN_VIEW_HEIGHT))
        
        let dataItem = DataItem(itemID: "0", itemName: "Breakfast")
        let dataItem2 = DataItem(itemID: "1", itemName: "Lunch")
        let dataItem3 = DataItem(itemID: "2", itemName: "Dinner")
        let dataItem4 = DataItem(itemID: "3", itemName: "Snack")
        
        let dropDownData = [ dataItem, dataItem2, dataItem3, dataItem4 ]
        
        self.dropdownView?.dropdownData = dropDownData
    }
    */
    
    @IBAction func addReceiptImage(sender: AnyObject)
    {
        let action = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        action.addAction(UIAlertAction(title: "Gallery", style: .Default, handler:
        { _ in
            self.presentImagePicker(.PhotoLibrary)
        }))
        
        action.addAction(UIAlertAction(title: "Camera", style: .Default, handler:
        { _ in
            self.presentImagePicker(.Camera)
        }))
        
        if let ppc = action.popoverPresentationController
        {
            ppc.sourceView = self.programInfoView.receiptButton
            ppc.sourceRect = self.programInfoView.receiptButton.bounds
        }
        
        self.mainViewController!.presentViewController(action, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        let picker = self.imagePicker
        picker.allowsEditing = false
        picker.sourceType = sourceType
        //self.imagePicker!.delegate = self
        
        self.mainViewController!.presentViewController(picker, animated: true)
        {
            
        }
    }
    
    @IBAction func save(sender: AnyObject)
    {
        if self.programInfoView.validateFormFields() == true
        {
            self.saveData()
            
            self.mainViewController?.showScreen(NavScreen.Registration, size: self.mainViewController!.mainScrollView.size)
        }
        else
        {
            let alertMessage = AlertMessage(title: "", message: Constants.Strings.ALERT_MESSAGE_REQUIRED_FIELDS, buttons: ["Skip", "OK"], buttonLayoutType: ButtonLayoutType.Horizontal)
            let alertView = AlertDialogView(message: alertMessage)
            self.view.addSubview(alertView)
            alertView.centerInSuperview()
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProgramInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.receiptImage = image
        
        self.mainViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.mainViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}
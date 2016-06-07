//
//  RegistrationViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController
{
    @IBOutlet var eventHeaderView: EventHeaderView!
    @IBOutlet var registrationView: RegistrationView!
    @IBOutlet var drawingView: DrawingView!
    @IBOutlet var canvasView: CanvasView!
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
      //  self.registrationView.populateFields()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // self.drawingView.delegate = self
        
       // self.canvasView.delegate = self

        self.eventHeaderView.participantCount = EventItem.currentEventItem?.getParticipantCount()
        
       // let touchGesture = UIPanGestureRecognizer(target: self, action: #selector(RegistrationViewController.touchPanned(_:)))
       // self.view.addGestureRecognizer(touchGesture)
    }
    
    override func loadData()
    {
        if let participant = Participant.currentParticipant
        {
            self.registrationView.participant = participant
        }
    }
    
    override func saveData()
    {
        let participant = Participant()
        participant.firstName = self.registrationView.firstName.text
        participant.lastName = self.registrationView.lastName.text
        participant.title = self.registrationView.title.text
        participant.city = self.registrationView.city.text
        participant.state = self.registrationView.state.selectedItem
        participant.signature = self.canvasView.image//.drawingImag
        Participant.currentParticipant = participant
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onAction(sender: UIButton)
    {
        if self.registrationView.validateFormFields() == true
        {
            let mealAccepted = (sender.tag == 0 ? true : false)
            
            let event = EventItem.currentEventItem
            
            self.saveData()
            
            let participant = Participant.currentParticipant
            participant?.meal = mealAccepted
            
            let parameters = [ "first_name" : participant!.firstName!,
                               "last_name" : participant!.lastName!,
                               "city" : participant!.city!,
                               "state" : (participant!.state != nil ? participant!.state!.itemID! : "")
                            ]
            
            let apiRequest = APIRequest(url: Constants.NPI_URL, endPoint: "", requestType: Constants.HTTPRequestMethods.HTTP_GET, parameters: parameters ) as APIRequest
            
            APIManager.sharedManager.getAPIRequestNamed(apiRequest)
            { (data, error) in
                let results = data!["results"] as? [[String : AnyObject]]
                if results != nil && !(results?.isEmpty)!
                {
                    let npi = NPIObject(json: results!.first!)
                    participant!.npiObject = npi
                }
                
                event?.participants.append(participant!)
                EventItem.currentEventItem = event
  
                Participant.currentParticipant = Participant()
                
                self.clear(nil)
            }
        }
        else
        {
            let alertMessage = AlertMessage(title: "", message: Constants.Strings.ALERT_MESSAGE_FIELDS_MISSING, buttons: ["OK"], buttonLayoutType: ButtonLayoutType.Horizontal)
            let alertView = AlertDialogView(message: alertMessage)
            self.view.addSubview(alertView)
            alertView.centerInSuperview()
        }
    }
    
    
    
    @IBAction func clear(sender: AnyObject?)
    {
        self.loadData()
        self.canvasView.clearCanvas(animated: true)
    }
    
    /*
    func touchPanned(gesture: UIPanGestureRecognizer)
    {
        if gesture.state == UIGestureRecognizerState.Began
        {
            self.reticleView.hidden = false
            self.updateReticleView()
        }
        else if gesture.state == UIGestureRecognizerState.Changed
        {
            self.canvasView.drawTouches([UITouch](), withEvent: UIEvent())
            //self.canvasView.drawTouches(touches, withEvent: UIEvent())
        }
        else if gesture.state == UIGestureRecognizerState.Ended
        {
            self.canvasView.drawTouches([UITouch](), withEvent: UIEvent())
            self.canvasView.endTouches()
        }
    }
    
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>)
    {
        self.canvasView.updateEstimatedPropertiesForTouches(touches)
        
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegistrationViewController: DrawingViewDelegate
{
    func drawingViewDidstart(drawingView: DrawingView)
    {
        self.mainViewController?.mainScrollView.scrollEnabled = false
    }
    
    func drawingViewDidFinish(drawingView: DrawingView)
    {
        self.mainViewController?.mainScrollView.scrollEnabled = true
    }
}

extension RegistrationViewController: UITextFieldDelegate
{
    func textFieldDidEndEditing(textField: UITextField)
    {
        if textField == self.registrationView.title
        {
            let title = ParticipantTitle.getTitleForString(textField.text!)
            
            if title == ParticipantTitle.PhysicianDO || title == ParticipantTitle.PhysicianMD || title == ParticipantTitle.NursePractitioner || title == ParticipantTitle.PhysicianAsst
            {
                self.registrationView.city.hidden = false
                self.registrationView.state.hidden = false
            }
        }
    }
}

/*
extension RegistrationViewController: CanvasViewDelegate
{
    func canvasViewDidStartDrawing(canvasView: CanvasView)
    {
        //self.mainViewController?.mainScrollView.scrollEnabled = false
    }
    
    func canvasViewDidCompleteDrawing(canvasView: CanvasView)
    {
       // self.mainViewController?.mainScrollView.scrollEnabled = true
    }
}*/
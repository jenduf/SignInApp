//
//  ReportViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ReportViewController: BaseViewController
{
    @IBOutlet var reportTableView: UITableView!
    @IBOutlet var eventHeaderView: EventHeaderView!
    @IBOutlet var reportHeaderView: ReportHeaderView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func loadData()
    {
        self.eventHeaderView.participantCount = EventItem.currentEventItem?.getParticipantCount()
        
        self.reportHeaderView.user = User.currentUser

        self.reportHeaderView.event = EventItem.currentEventItem
        
        self.reportTableView.reloadData()
    }
    
    @IBAction func exportScreen(sender: AnyObject)
    {
        
       let controller = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let sendAction = UIAlertAction(title: "Send Email", style: .Default)
        { (alert: UIAlertAction) in
            //let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
            //let label = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 80))
         //   label.text = "What type of report do you want?"
           // label.numberOfLines = 0
           // label.lineBreakMode = NSLineBreakMode.ByWordWrapping
           // label.textAlignment = NSTextAlignment.Center
           // label.textColor = UIColor.whiteColor()
           // view.addSubview(label)
            //view.backgroundColor =
            
            let alertMessage = AlertMessage(title: "", message: Constants.Strings.ALERT_MESSAGE_SAVE_PROMPT, buttons: ["PDF", "CSV"], buttonLayoutType: ButtonLayoutType.Horizontal)
            let alertView = AlertDialogView(message: alertMessage)
          //  (title: "", message: "", delegate: self, cancelButtonTitle: "PDF", otherButtonTitles: "CSV", nil)
            self.view.addSubview(alertView)
            alertView.centerInSuperview()
        }
        
        if let popoverController = controller.popoverPresentationController
        {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = sender.bounds
        }
        
        controller.addAction(sendAction)
        
        self.mainViewController!.presentViewController(controller, animated: true)
        {
            
        }
       
        /*
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
        }*/
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

extension ReportViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let event = EventItem.currentEventItem
        {
            return event.participants.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let participant = EventItem.currentEventItem!.participants[indexPath.row] as Participant
        
        let participantCell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.PARTICIPANT_REPORT_CELL_IDENTIFIER) as! ParticipantCell
        participantCell.participant = participant
        
        return participantCell
    }
}

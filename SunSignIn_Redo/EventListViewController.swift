//
//  EventListViewController.swift
//  Sign In
//
//  Created by Jennifer Duffey on 5/26/16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EventListViewController: UIViewController
{
    @IBOutlet var eventTableView: UITableView!
    
    var events = [EventItem]()

    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock:
        { snapshot in
            
            var newItems = [EventItem]()
            
            for item in snapshot.children
            {
                print("item key: \((item as! FIRDataSnapshot).key) item value: \((item as! FIRDataSnapshot).value)")
                
                if let dict = snapshot.value as? NSDictionary
                {
                    for event in dict.allKeys
                    {
                        if let eventDict = dict[event as! String] as? NSDictionary
                        {
                            for eventKey in eventDict.allKeys
                            {
                                print("EVENT KEY: \(eventKey)")
                                
                                if let otherEventDict = eventDict[eventKey as! String] as? NSDictionary
                                {
                                    print("EVENT VALUE: \(otherEventDict)")
                                    
                                    let eventID = otherEventDict.allKeys.first
                                    
                                    let eventItem = EventItem(key: eventKey as! String, eventID: eventID as! String, eventDict: otherEventDict)
                                    newItems.append(eventItem)
                                }
                            }
                        }
                    }
                }
            }
            
            self.events = newItems
            self.eventTableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension EventListViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCellIdentifier") as! EventCell
     
        let event = self.events[indexPath.row]
        
        cell.eventItem = event
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
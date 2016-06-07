//
//  ReviewViewController.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

class ReviewViewController: BaseViewController
{
    @IBOutlet var reviewTableView: UITableView!
    @IBOutlet var eventHeaderView: EventHeaderView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.eventHeaderView.participantCount = EventItem.currentEventItem?.getParticipantCount()
    }
    
    override func loadData()
    {
        self.reviewTableView.reloadData()
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

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate
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
        
        let participantCell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.PARTICIPANT_CELL_IDENTIFIER) as! ParticipantCell
        participantCell.participant = participant
        
        return participantCell
    }
}
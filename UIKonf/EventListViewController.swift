//
//  EventListViewController.swift
//  UIKonf
//
//  Copyright © 2016 Raised by Wolves. All rights reserved.
//

import UIKit
import IBAnimatable
import Reusable

class EventListViewController: UITableViewController {
    
    let events = Event.allEvents

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(BasicTableViewCell)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as BasicTableViewCell
        cell.accessoryType = .DisclosureIndicator
        let event = events[indexPath.row]
        cell.configure(withTitle: event.name, detail: event.description, imageResource: event.imageResource)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(R.segue.eventListViewController.showEventRegistration, sender: self)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let animatableCell = cell as? AnimatableTableViewCell {
            animatableCell.animate()
        }
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let segueInfo = R.segue.eventListViewController.showEventRegistration(segue: segue),
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            segueInfo.destinationViewController.event = events[selectedIndexPath.row]
        }
    }
}

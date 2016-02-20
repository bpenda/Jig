//
//  NewEntryViewController.swift
//  Jig
//
//  Created by Ben Moore on 2/20/16.
//  Copyright © 2016 vbhi. All rights reserved.
//


import UIKit

class NewEntryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var entryTable: UITableView!
    @IBAction func add(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTable.delegate = self
        entryTable.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("EntryCell")! as UITableViewCell
        let timeLabel = cell.viewWithTag(7) as! UILabel
        timeLabel.text = String(indexPath.row+3)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
}



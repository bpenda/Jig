//
//  ProfileViewController.swift
//  Jig
//
//  Created by Ben Moore on 2/20/16.
//  Copyright © 2016 vbhi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileTable: UITableView!
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTable.delegate = self
        profileTable.dataSource = self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ProfileSetting")! as UITableViewCell
        let timeLabel = cell.viewWithTag(5) as! UILabel
        timeLabel.text = String(indexPath.row+2)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
}


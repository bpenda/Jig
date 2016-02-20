//
//  MainViewController.swift
//  Jig
//
//  Created by Ben Moore on 2/20/16.
//  Copyright © 2016 vbhi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 24
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Event")! as UITableViewCell
            let timeLabel = cell.viewWithTag(3) as! UILabel
            let titleLabel = cell.viewWithTag(2) as! UILabel
            timeLabel.text = String(indexPath.row)+"0:00"
            titleLabel.text = String(indexPath.row+1)
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            // cell selected code here
    }
}
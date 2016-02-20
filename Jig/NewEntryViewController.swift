//
//  NewEntryViewController.swift
//  Jig
//
//  Created by Ben Moore on 2/20/16.
//  Copyright © 2016 vbhi. All rights reserved.
//


import UIKit

class NewEntryViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    @IBOutlet weak var field5: UITextField!

    @IBAction func add(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
        //allEntries.append(Entry(label: self.field1.text!, time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(30*60), sinceDate: NSDate()), length: Double(self.field2.text!)!, type: .homework, priority: 1, location: self.field3.text!))
            print(self.field1.text)
        })
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if ((textField == field5) || (textField == field4) || (textField == field3)){
        scrollView.setContentOffset(CGPoint(x: 0,y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}



//
//  Entry.swift
//  Jig
//
//  Created by Vasil Pendavinji on 2/19/16.
//  Copyright © 2016 vbhi. All rights reserved.
//

import Foundation

class Entry {
    
    var label:String = ""
    var time:NSTimeInterval = 0
    var length:NSTimeInterval = 0
    var deadline:NSTimeInterval = 0
    var type:Type = .other
    var priority:Int =  5
    var location:String = ""
    var doable:Bool = true
    
    enum Type{
        case course
        case meeting
        case homework
        case activity
        case other
    }
    
    init(label:String, time:NSDate, deadline:NSDate, length: NSTimeInterval, type:Type,priority:Int, location:String ){
        self.label = label
        self.time = time.timeIntervalSince1970
        self.length = length
        self.deadline = deadline.timeIntervalSince1970
        self.type = type
        self.priority = priority
        self.location = location
    }
}
//
//  AppDelegate.swift
//  Jig
//
//  Created by Vasil Pendavinji on 2/19/16.
//  Copyright © 2016 vbhi. All rights reserved.
//

import UIKit

var allEntries = [Entry]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var entriesByWeek = [[Entry]]()
    var currentDate:NSDate = NSDate()
    var startTime = 8.0
    var workTime = NSTimeInterval(12*60*60)
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        currentDate = NSDate()
        allEntries.append(Entry(label: "hw1", time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(30*60), sinceDate: NSDate()), length: NSTimeInterval(120*60), type: .homework, priority: 1, location: ""))
        
        allEntries.append(Entry(label: "hw2", time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(300*60), sinceDate: NSDate()), length: NSTimeInterval(250*60), type: .homework, priority: 1, location: ""))
        
        allEntries.append(Entry(label: "hw3", time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(400*60), sinceDate: NSDate()), length: NSTimeInterval(20*60), type: .homework, priority: 1, location: ""))
        
        allEntries.append(Entry(label: "hw4", time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(90*60), sinceDate: NSDate()), length: NSTimeInterval(10*60), type: .homework, priority: 1, location: ""))
        
        allEntries.append(Entry(label: "hw5", time: NSDate(), deadline: NSDate(timeInterval: NSTimeInterval(120*60), sinceDate: NSDate()), length: NSTimeInterval(10*60), type: .homework, priority: 1, location: ""))
        
        sortByDeadline()
        planWeek(0)
        for entry:Entry in allEntries{
            print(entry.label)
        }

        for var i = 0; i < entriesByWeek[0].count; i++ {
            print("0 ",entriesByWeek[0][i].label, " completed on time: ", (entriesByWeek[0][i].time + entriesByWeek[0][i].length) <= entriesByWeek[0][i].deadline, ", time til deadline: ", (entriesByWeek[0][i].deadline - (entriesByWeek[0][i].time + entriesByWeek[0][i].length))/60 )
        }

        return true
    }
    
    func sortByDeadline(){
        allEntries.sortInPlace { $0.deadline < $1.deadline }
    }
    
    func planWeek(week:Int){
        var i = 0, d = 1
        let baseTime = firstDateOfWeekWithDate(currentDate) + Double(7*24*3600 * week)
        if(entriesByWeek.count == 0){
            d = getDayOfWeek(currentDate)
        }
        if(entriesByWeek.count <= week){
            entriesByWeek.append([Entry]())
        }
        for ; d <= 7; d++ {
            for ; i < allEntries.count; i++ {
                let length = allEntries[i].length
                if(entriesByWeek[week].count == 0){
                    let newTime = computeTimeOffset(baseTime, day: d, start: startTime)
                    entriesByWeek[week].append(allEntries[i])
                    entriesByWeek[week][0].time = newTime
                }else{
                    //iterate through every entry for day d and insert where possible
                    for var e = 0; e < entriesByWeek[week].count; e++ {
                        let existingEntry = entriesByWeek[week][e]
                        if(e == 0){
                            let below = entriesByWeek[week][e]
                            let endOfAbove = computeTimeOffset(baseTime, day: d, start: startTime)
                            let beginningOfBelow = below.time
                            if(beginningOfBelow - endOfAbove > length){
                                entriesByWeek[week].insert(allEntries[i], atIndex: 0)
                                let newEntry = entriesByWeek[week][0]
                                newEntry.time = existingEntry.time - length
                            }else{
                                let above = entriesByWeek[week][e]
                                let endOfAbove = above.time + above.length
                                let beginningOfBelow = computeTimeOffset(baseTime, day: d, start: startTime) + workTime
                                if(beginningOfBelow - endOfAbove > length){
                                    entriesByWeek[week].insert(allEntries[i],atIndex: 1)
                                    entriesByWeek[week][1].time = endOfAbove
                                }
                            }
                            break
                        }
                        else if(e == entriesByWeek[week].count-1){
                            let above = entriesByWeek[week][e]
                            let endOfAbove = above.time + above.length
                            let beginningOfBelow = workTime + computeTimeOffset(baseTime, day: d, start: startTime)
                            if(beginningOfBelow - endOfAbove > length){
                                entriesByWeek[week].insert(allEntries[i],atIndex: e + 1)
                                entriesByWeek[week][e + 1].time = endOfAbove
                            }
                            break
                        }
                        let above = entriesByWeek[week][e]
                        let below = entriesByWeek[week][e + 1]
                        let endOfAbove = above.time + above.length
                        let beginningOfBelow = below.time
                        if(beginningOfBelow - endOfAbove > length){
                            entriesByWeek[week].insert(allEntries[i],atIndex: e + 1)
                            entriesByWeek[week][e + 1].time = endOfAbove
                            
                        }
                    }
                }
            }
        }
    }
    
    func determineConflicts(){
        
    }
    
    func getDayOfWeek(date:NSDate) -> Int {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: date)
        let weekDay = myComponents.weekday
        return weekDay
    }
    
    func getMinute(date:NSDate) -> Int {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Minute, fromDate: date)
        let minute = myComponents.minute
        return minute
    }
    
    func firstDateOfWeekWithDate(date: NSDate) -> NSTimeInterval {
        
        var beginningOfWeek: NSDate?
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        myCalendar.rangeOfUnit(.WeekOfYear, startDate: &beginningOfWeek, interval: nil, forDate: date)
        
        return beginningOfWeek!.timeIntervalSince1970
        
    }
    
    func computeTimeOffset(base:NSTimeInterval, day:Int, start:Double) -> NSTimeInterval {
        let startOff =  start*3600.0
        let dayOff = 24.0*3600.0*Double(day-1)
        return base + startOff + dayOff
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


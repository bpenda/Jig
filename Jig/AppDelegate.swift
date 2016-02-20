//
//  AppDelegate.swift
//  Jig
//
//  Created by Vasil Pendavinji on 2/19/16.
//  Copyright © 2016 vbhi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var allEntries = [Entry]()
    var entriesByWeek = [[Entry]]()
    var currentDate:NSDate = NSDate();
    var workTime = NSTimeInterval(12*60*60)
    var crunchTime = NSTimeInterval(4*60*60)

    

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        currentDate = NSDate()
        return true
    }
    
    func sortByDeadline(inout entries:[Entry]){
        entries.sortInPlace { $0.deadline.compare($1.deadline) == .OrderedAscending }
    }
    
    func planWeek(){
        var i = 0;
        var w = 1;
        if(entriesByWeek.count == 0){
            w = getDayOfWeek(currentDate)
        }
        for ; w <= 7; w++ {
            var budget:NSTimeInterval = NSTimeInterval(0)
            for ; i < allEntries.count; i++ {
                
            }
        }
    }
    
    func determineConflicts(inout entries:[Entry]){
        
    }
    
    func getDayOfWeek(date:NSDate) -> Int {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: date)
        let weekDay = myComponents.weekday
        return weekDay
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


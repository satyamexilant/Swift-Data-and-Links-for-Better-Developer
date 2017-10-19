//
//  TestingClass.swift
//  CustomNotificationCenter
//
//  Created by padalingam agasthian on 10/02/16.
//  Copyright © 2016 padalingam agasthian. All rights reserved.
//

import Cocoa

class TestingClass: NSObject
{
    func someMethod(notification:Notification)
    {
        for _ in 1...10
        {
        print("i am in Testing Class \(notification.object)")
        }
    }
    
    func someTwo(notification:Notification)
    {
        for _ in 1...10
        {
        print("i am in method two \(notification.object)")
        }
    }

}

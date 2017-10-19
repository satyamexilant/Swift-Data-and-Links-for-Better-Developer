//
//  Notification.swift
//  CustomNotificationCenter
//
//  Created by padalingam agasthian on 10/02/16.
//  Copyright © 2016 padalingam agasthian. All rights reserved.
//

import Cocoa

class Notification: NSObject
{
    var name : String?
    var object : AnyObject?
    var userInfo :[NSObject:AnyObject]?
    init(name:String,object:AnyObject?,userInfo:[NSObject:AnyObject]?)
    {
        self.name = name
        self.object = object
        self.userInfo = userInfo
    }
}

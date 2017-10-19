//
//  ViewController.swift
//  CustomNotificationCenter
//
//  Created by padalingam agasthian on 10/02/16.
//  Copyright © 2016 padalingam agasthian. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
    var testingClass : TestingClass?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        CustomNoticationCenter.defaultCenter.addObserver(self, selector: Selector("someMethod:"), name: "MyNotification", object: self)
        testingClass = TestingClass()
        CustomNoticationCenter.defaultCenter.addObserver(testingClass!, selector: Selector("someMethod:"), name: "MyNotification", object: nil)
        CustomNoticationCenter.defaultCenter.addObserver(testingClass!, selector: Selector("someTwo:"), name: "MyNotification", object: nil)
       // CustomNoticationCenter.defaultCenter.postAsynNotificationName("MyNotification", object: nil)
        CustomNoticationCenter.defaultCenter.postNotificationName("MyNotification", object: nil, userInfo: ["some":12])
        CustomNoticationCenter.defaultCenter.removeObserver(testingClass!)
        CustomNoticationCenter.defaultCenter.postNotificationName("MyNotification", object: nil)
        CustomNoticationCenter.defaultCenter.postNotification(Notification(name: "MyNotification", object: nil, userInfo: ["first":24]))
    }

    override var representedObject: AnyObject?
    {
        didSet
        {
        
        }
    }
    
    func someMethod(notification:Notification)
    {
        for _ in 1...10
        {
           print("i am in view controller \(notification.object) and \(notification.userInfo)")
        }
      
    }
}


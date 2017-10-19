//
//  CustomNoticationCenter.swift
//  CustomNotificationCenter
//
//  Created by padalingam agasthian on 10/02/16.
//  Copyright © 2016 padalingam agasthian. All rights reserved.
//

import Cocoa

class CustomNoticationCenter: NSObject
{
    var dispatchTable = [(observer:AnyObject,selector:Selector,name:String,object:AnyObject?)]()
    class var defaultCenter : CustomNoticationCenter
    {
        struct Static
        {
            static var onceToken : dispatch_once_t = 0
            static var instance : CustomNoticationCenter? = nil
        }
        dispatch_once(&Static.onceToken)
        {
            Static.instance = CustomNoticationCenter()
        }
        return Static.instance!
    }
    
    func addObserver(observer: AnyObject,selector aSelector: Selector,
        name aName: String,
        object anObject: AnyObject?)
    {
       dispatchTable.append((observer,aSelector,aName,anObject))
    }
    
    func postNotificationName(aName: String,object anObject: AnyObject?)
    {
        let postNotificationList = dispatchTable.filter{$0.name==aName}
        for tuple in postNotificationList
        {
            let notification = Notification(name: aName, object: anObject, userInfo: nil)
            let methodCall = tuple.selector
            if let senderObject = anObject where senderObject.isEqual(tuple.object)
            {
                if String(tuple.selector).hasSuffix(":")
                    {
                       tuple.observer.performSelector(methodCall, withObject: notification)
                    }
                else
                    {
                        tuple.observer.performSelector(methodCall)
                    }
            }
            if anObject == nil
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                        { () -> Void in
                    tuple.observer.performSelector(methodCall, withObject: notification)
                    }
                }
                else
                {
                    tuple.observer.performSelector(methodCall)
                }
            }
        }
    }
    
    func postAsynNotificationName(aName: String,object anObject: AnyObject?)
    {
        let postNotificationList = dispatchTable.filter{$0.name==aName}
        for tuple in postNotificationList
        {
            let notification = Notification(name: aName, object: anObject, userInfo: nil)
            let methodCall = tuple.selector
            if let senderObject = anObject where senderObject.isEqual(tuple.object)
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                    { () -> Void in
                        tuple.observer.performSelector(methodCall, withObject: notification)
                    }
                }
                else
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                    { () -> Void in
                        tuple.observer.performSelector(methodCall)
                    }
                }
            }
            if anObject == nil
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                    { () -> Void in
                        tuple.observer.performSelector(methodCall, withObject: notification)
                    }
                }
                else
                {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                    { () -> Void in
                        tuple.observer.performSelector(methodCall)
                    }
                }
            }
        }
    }
    
    func postNotificationName(aName: String,object anObject: AnyObject?,userInfo aUserInfo: [NSObject : AnyObject]?)
    {
        let postNotificationList = dispatchTable.filter{$0.name==aName}
        for tuple in postNotificationList
        {
           let notification = Notification(name: aName, object: anObject, userInfo: aUserInfo)
           let methodCall = tuple.selector
            if let senderObject = anObject where senderObject.isEqual(tuple.object)
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    tuple.observer.performSelector(methodCall, withObject: notification)
                }
                else
                {
                    tuple.observer.performSelector(methodCall)
                }
            }
            if anObject == nil
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    tuple.observer.performSelector(methodCall, withObject: notification)
                }
                else
                {
                    tuple.observer.performSelector(methodCall)
                }
            }
        }
    }
    
    func postNotification(notification:Notification)
    {
        let postNotificationList = dispatchTable.filter{$0.name==notification.name}
        for tuple in postNotificationList
        {
            let methodCall = tuple.selector
            if let senderObject = notification.object where senderObject.isEqual(tuple.object)
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    tuple.observer.performSelector(methodCall, withObject: notification)
                }
                else
                {
                    tuple.observer.performSelector(methodCall)
                }
            }
            if notification.object == nil
            {
                if String(tuple.selector).hasSuffix(":")
                {
                    tuple.observer.performSelector(methodCall, withObject: notification)
                }
                else
                {
                    tuple.observer.performSelector(methodCall)
                }
            }
        }

    }
    
    func removeObserver(observer: AnyObject,name aName: String?,object anObject: AnyObject?)
    {
        for dispathtable in dispatchTable  where dispathtable.observer.isEqual(observer) && dispathtable.name == aName && dispathtable.object!.isEqual(anObject)
        {
            self.dispatchTable.removeAtIndex(dispatchTable.indexOf({ (dispatch) -> Bool in
                return dispatch.observer.isEqual(observer)
            })!)
        }
    }
    
    func removeObserver(observer: AnyObject)
    {
        for dispathtable in dispatchTable  where dispathtable.observer.isEqual(observer)
        {
           dispatchTable.removeAtIndex(dispatchTable.indexOf({ (dispatch) -> Bool in
            return dispatch.observer.isEqual(observer)
           })!)
        }
    }
}

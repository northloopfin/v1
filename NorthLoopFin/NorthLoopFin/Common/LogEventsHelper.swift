//
//  LogEvents.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 26/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import Amplitude_iOS
class logEventsHelper:NSObject{
    
    class func logEventWithName(name:String, andProperties:Dictionary<String,String>){
        Amplitude.instance()?.logEvent(name, withEventProperties: andProperties)
    }
    
    class func logEventsWithName(name:String){
        Amplitude.instance()?.logEvent(name)
    }
    
}

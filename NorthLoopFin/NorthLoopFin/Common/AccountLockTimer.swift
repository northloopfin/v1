//
//  AccountLockTimer.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Repeat

///This class is responsible to check whther user account is blocked or not.
class AccountLockTimer: NSObject {
    static let sharedInstance = AccountLockTimer()
    var timer:Repeater? = nil
    var timer30:Repeater? = nil
    
    override init() {
        super.init()
    }
    
    func startTimer(){
        self.timer = Repeater(interval: .minutes(1), mode: .once) { _ in
            //self.timer?.pause
            print("Timer complete")
            UserInformationUtility.sharedInstance.userattemptsIn10Min=0
        }
        timer?.start()
    }
    func startTimer30(){
        self.timer = Repeater(interval: .minutes(10), mode: .once) { _ in
            //self.timer?.pause
            print("Timer complete")
            UserInformationUtility.sharedInstance.userattepmtsIn30Min=0
        }
        timer?.start()
    }
}

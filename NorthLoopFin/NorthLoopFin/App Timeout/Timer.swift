//
//  Timer.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

/** Source of this code with awesome Blog https://blog.gaelfoppolo.com/detecting-user-inactivity-in-ios-application-684b0eeeef5b **/
import Foundation
import UIKit

class TouchTimer: UIApplication {
    
    // the timeout in seconds, after which should perform custom actions
    // such as disconnecting the user
    private var timeoutInSeconds: TimeInterval {
        // 1 minutes
        return 2 * 60
    }
    
    private var idleTimer: Timer?
    
    // resent the timer because there was user interaction
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                         target: self,
                                         selector: #selector(TouchTimer.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        NotificationCenter.default.post(name: .appTimeout,
                                        object: nil
        )
    }
    
    override func sendEvent(_ event: UIEvent) {
        
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                self.resetIdleTimer()
            }
        }
    }
}

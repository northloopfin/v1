

import UIKit
import Reachability

class ReachabilityManager: NSObject{
    
    //Shared instance
    static  let shared = ReachabilityManager()

    //Boolean to track network reachability
    var isNetworkAvailable : Bool! = false
    
    //Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .none
    
    //Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
            
        case .none:
            isNetworkAvailable = false
            debugPrint("Network became unreachable")            
        case .wifi:
            isNetworkAvailable = true
            debugPrint("Network reachable through WiFi")
        case .cellular:
            isNetworkAvailable = true
            debugPrint("Network reachable through Cellular Data")
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: self.reachability)
        
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }

}

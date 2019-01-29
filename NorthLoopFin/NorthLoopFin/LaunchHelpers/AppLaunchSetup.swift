
import Foundation
import AFNetworking
import GoogleMaps
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import DropDown

class AppLaunchSetup: NSObject {
    
    /*
     Create Singleton object for the class
     */
    static let shareInstance = AppLaunchSetup()
    
    private override init() {
    }

    
    /**
     This method is used to enable network rechability monitoring
     */
    func startMonitoringNetworkRechability(){
        ReachabilityManager.shared.startMonitoring()
        AFNetworkReachabilityManager.shared().startMonitoring()
    }
    func initialiseThirdPartyIfAny(){
        GMSServices.provideAPIKey(AppConstants.GoogleMapAPIKey ?? "")
        IQKeyboardManager.shared.enable = true
        //DropDown.startListeningToKeyboard()
        Fabric.with([Crashlytics.self])
    }
}

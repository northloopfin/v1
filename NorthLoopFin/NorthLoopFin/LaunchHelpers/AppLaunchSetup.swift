
import Foundation
import AFNetworking
import GoogleMaps
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import DropDown
import Amplitude_iOS
import ZDCChat


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
        Fabric.sharedSDK().debug = true

        BITHockeyManager.shared().configure(withIdentifier: "6b2ccf1e4a40462cb0018114afe4f80d")
        // Do some additional configuration if needed here
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
        //Configure Firebase
        Amplitude.instance()?.initializeApiKey("e60c4b5547bbd53ae65dab02520fd3ab")
        //Configure Zendesk Chat
        ZDCChat.initialize(withAccountKey: "lQGQv5IQfRok3EAC8hQglkuCOgB6xs3N")
//        [[ZDCChatUI appearance] setBackChatButton"Image:@"SampleBackground"];
        
    }
}

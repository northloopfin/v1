
import Foundation
import AFNetworking
import GoogleMaps
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import DropDown
import Firebase
import Amplitude_iOS
import ZendeskSDK
import ZendeskCoreSDK


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
        FirebaseApp.configure()
        Amplitude.instance()?.initializeApiKey("e60c4b5547bbd53ae65dab02520fd3ab")
        
        // Initialize Zendesk
        Zendesk.initialize(appId: "00ca8f987b37a9caeefb796b76ca62d145d851439c3b8241",
                           clientId: "mobile_sdk_client_76a94439fa38a9e41ecb",
                           zendeskUrl: "https://northloop.zendesk.com")
        Support.initialize(withZendesk: Zendesk.instance)
        
    }
}

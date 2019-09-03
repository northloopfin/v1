//
//  AppDelegate.swift
//  NorthLoopFin
//
//  Created by Daffodil on 03/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu
import UserNotifications
import Firebase
import IQKeyboardManagerSwift
import FirebaseDynamicLinks
import FirebaseAuth
import FirebaseDatabase
import RealmSwift


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var cardInfo: CardInfo?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // if crash happen prior delete local database
        // Override point for customization after application launch.
        self.registerForPushNotifications()
        print(StorageHelper.getDirectoryPath())

        Amplitude.instance()?.initializeApiKey(AppConstants.AmplitudeAPIKey)
        
        //Configure Firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        //Setting up custon navigation controller
        AppLaunchSetup.shareInstance.startMonitoringNetworkRechability()
        AppLaunchSetup.shareInstance.initialiseThirdPartyIfAny()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil
        )
        sleep(2)
        self.initialViewController()
        
        // Line to catch exceptions
        //NSSetUncaughtExceptionHandler(uncaughtExceptionHandler);exce
        NSSetUncaughtExceptionHandler { (exception) in
            print(exception)
            UserDefaults.saveToUserDefault(true as AnyObject, key: AppConstants.UserDefaultKeyForCrash)
        }
        
        DynamicLinks.performDiagnostics(completion: nil)

        let config = Realm.Configuration(
            schemaVersion: 1,  //Increment this each time your schema changes
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForCrash){
            RealmHelper.deleteAllFromDatabase()
            UserInformationUtility.sharedInstance.deleteCurrentUser()
            UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForCrash)
        }

        
//        if (launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]) != nil{
//            self.logEventForAppOpen(source: "Push Notification")
//        }else{
//            self.logEventForAppOpen(source: "Direct")
//        }
        return true
    }
    

    func logEventForAppOpen(source: String){
        let eventProperties:[String:String] = ["Source":source]
        let eventName:String = "App Open"
        logEventsHelper.logEventWithName(name: eventName, andProperties: eventProperties)
    }
    
    func logEventForAppClose(){
        logEventsHelper.logEventsWithName(name: "App Close")
    }
    
    func initialViewController() ->Void
    {
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        var identifier = "WelcomeViewController"
        if UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForOnboarding) == nil{
            identifier = "OnboardingVC"
        }
        let vc:UIViewController = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.moveToScreen(vc: vc)
    }
    
    class func getDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //Remove this code once Client confirm..Requirements not clear here
//    func moveUserToScreenWhereLeft(){
//        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
//        var vc:UIViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: WelcomeViewController.self)) as!  WelcomeViewController
//        if let screen:String = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForScreen) as? String{
//            switch screen {
//                case AppConstants.Screens.USERDETAIL.rawValue:
//                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: CreateAccountV2ViewController.self)) as!  CreateAccountV2ViewController
//                    self.moveToScreen(vc: vc)
//                case AppConstants.Screens.OTP.rawValue:
//                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: OTPViewController.self)) as!  OTPViewController
//                    self.moveToScreen(vc: vc)
//                case AppConstants.Screens.SCANID.rawValue:
//                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: ScanIDViewController.self)) as!  ScanIDViewController
//                    self.moveToScreen(vc: vc)
//                case AppConstants.Screens.SELFIETIME.rawValue:
//                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: SelfieViewController.self)) as!  SelfieViewController
//                    self.moveToScreen(vc: vc)
//                case AppConstants.Screens.VERIFYADDRESS.rawValue:
//                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: VerifyAddressViewController.self)) as!  VerifyAddressViewController
//                    self.moveToScreen(vc: vc)
//                case AppConstants.Screens.HOME.rawValue:
//                    self.moveToHomeScreen()
//            default:
//                break
//            }
//        }else{
//            self.moveToHomeScreen()
//        }
//    }
    
    func moveToScreen(vc:UIViewController){
        var initialNavigationController1:UINavigationController
        //let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: WelcomeViewController.self)) as!  WelcomeViewController
        initialNavigationController1 = UINavigationController(rootViewController:vc)
        initialNavigationController1.navigationBar.makeTransparent()
        self.window?.rootViewController = initialNavigationController1
        self.window?.makeKeyAndVisible()

    }
    @objc func applicationDidTimeout(notification: NSNotification) {
        
        print("application did timeout, perform actions")
        UserInformationUtility.sharedInstance.deleteCurrentUser()
        RealmHelper.deleteAllFromDatabase()
        self.initialViewController()
        
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            print(self.handleDynamicLink(dynamiclink))
        }
        
        return handled
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return application(app, open: url,
                           sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if DynamicLinks.dynamicLinks().shouldHandleDynamicLink(fromCustomSchemeURL: url) {
            let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
            return handleDynamicLink(dynamicLink)
        }
        // Handle incoming URL with other methods as necessary
        // ...
        return false
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }

    func handleDynamicLink(_ dynamicLink: DynamicLink?) -> Bool {
        guard let dynamicLink = dynamicLink else { return false }
        guard let deepLink = dynamicLink.url else { return false }
        let arr =  deepLink.lastPathComponent.components(separatedBy: "=")
        if arr.count == 2, arr[0] == "invited_by" {
            UserDefaults.saveToUserDefault(arr[1] as AnyObject, key: AppConstants.ReferralId)
        }else{
            if let invitedBy = getQueryStringParameter(url: deepLink.absoluteString, param: "invited_by"){
                UserDefaults.saveToUserDefault(invitedBy as AnyObject, key: AppConstants.ReferralId)
            }
        }
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        
        print("applicationWillResignActive")

        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
//        UserInformationUtility.sharedInstance.deleteCurrentUser()
//        RealmHelper.deleteAllFromDatabase()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
//        self.initialViewController()

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        self.logEventForAppClose()
        UserInformationUtility.sharedInstance.deleteCurrentUser()
        RealmHelper.deleteAllFromDatabase()
    }
    
    //Register for Push Notification
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
}

extension AppDelegate:UNUserNotificationCenterDelegate{
    //Notification Delegates
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        UserDefaults.saveToUserDefault(fcmToken as AnyObject, key: AppConstants.UserDefaultKeyForDeviceToken)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}

extension AppDelegate {
//    func application(_ app: UIApplication, open url: URL, options:
//        [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        if let isDynamicLink = DynamicLinks.dynamicLinks()?.shouldHandleDynamicLink(fromCustomSchemeURL: url),
//            isDynamicLink {
//            let dynamicLink = DynamicLinks.dynamicLinks()?.dynamicLink(fromCustomSchemeURL: url)
//            return handleDynamicLink(dynamicLink)
//        }
//        // Handle incoming URL with other methods as necessary
//        // ...
//        return false
//    }
//    
//    @available(iOS 8.0, *)
//    func application(_ application: UIApplication,
//                     continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
//        guard let dynamicLinks = DynamicLinks.dynamicLinks() else { return false }
//        let handled = dynamicLinks.handleUniversalLink(userActivity.webpageURL!) { (dynamicLink, error) in
//            if (dynamicLink != nil) && !(error != nil) {
//                self.handleDynamicLink(dynamicLink)
//            }
//        }
//        if !handled {
//            // Handle incoming URL with other methods as necessary
//            // ...
//        }
//        return handled
//    }
//    
//    func handleDynamicLink(_ dynamicLink: DynamicLink?) -> Bool {
//        guard let dynamicLink = dynamicLink else { return false }
//        guard let deepLink = dynamicLink.url else { return false }
//        let queryItems = URLComponents(url: deepLink, resolvingAgainstBaseURL: true)?.queryItems
//        let invitedBy = queryItems?.filter({(item) in item.name == "invitedby"}).first?.value
//        let user = Auth.auth().currentUser
//        // If the user isn't signed in and the app was opened via an invitation
//        // link, sign in the user anonymously and record the referrer UID in the
//        // user's RTDB record.
//        if user == nil && invitedBy != nil {
//            Auth.auth().signInAnonymously() { (user, error) in
//                if let user = user {
//                    let userRecord = Database.database().reference().child("users").child(user.uid)
//                    userRecord.child("referred_by").setValue(invitedBy)
//                    if dynamicLink.matchConfidence == .weak {
//                        // If the Dynamic Link has a weak match confidence, it is possible
//                        // that the current device isn't the same device on which the invitation
//                        // link was originally opened. The way you handle this situation
//                        // depends on your app, but in general, you should avoid exposing
//                        // personal information, such as the referrer's email address, to
//                        // the user.
//                    }
//                }
//            }
//        }
//        return true
//    }
}


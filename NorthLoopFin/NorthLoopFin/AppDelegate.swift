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


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sideMenuViewController:SideMenuViewController!
    let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboardManager.shared.enable = false
        //IQKeyboardManager.shared.enableAutoToolbar = false
        //UINavigationBar.appearance().isTranslucent = false
        
        // if crash happen prior delete local database
        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForCrash){
            RealmHelper.deleteAllFromDatabase()
            //StorageHelper.clearAllFileFromDirectory()
            UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForCrash)
        }
        // Override point for customization after application launch.
        self.registerForPushNotifications()
        print(StorageHelper.getDirectoryPath())

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
        self.logEventForAppOpen()
        
        // Line to catch exceptions
        //NSSetUncaughtExceptionHandler(uncaughtExceptionHandler);exce
        NSSetUncaughtExceptionHandler { (exception) in
            print(exception)
            UserDefaults.saveToUserDefault(true as AnyObject, key: AppConstants.UserDefaultKeyForCrash)
        }
        return true
    }
    

    func logEventForAppOpen(){
        let eventProperties:[String:String] = ["EventCategory":"Admin","Description":"triggers when the user opens the app"]
        let eventName:String = "App Open"
        logEventsHelper.logEventWithName(name: eventName, andProperties: eventProperties)
    }
    
    func logEventForAppClose(){
        let eventProperties:[String:String] = ["EventCategory":"Admin","Description":"when the user closes the app"]
        let eventName:String = "App Close"
        logEventsHelper.logEventWithName(name: eventName, andProperties: eventProperties)
    }
    
    func initialViewController() ->Void
    {
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        if let _:User = UserInformationUtility.sharedInstance.getCurrentUser(){
            self.moveUserToScreenWhereLeft()
        }else{
            let vc:UIViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: WelcomeViewController.self)) as!  WelcomeViewController
            self.moveToScreen(vc: vc)
        }
    }
    
    func moveUserToScreenWhereLeft(){
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc:UIViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: WelcomeViewController.self)) as!  WelcomeViewController
        if let screen:String = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForScreen) as? String{
            switch screen {
                case AppConstants.Screens.USERDETAIL.rawValue:
                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: CreateAccountV2ViewController.self)) as!  CreateAccountV2ViewController
                    self.moveToScreen(vc: vc)
                case AppConstants.Screens.OTP.rawValue:
                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: OTPViewController.self)) as!  OTPViewController
                    self.moveToScreen(vc: vc)
                case AppConstants.Screens.SCANID.rawValue:
                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: ScanIDViewController.self)) as!  ScanIDViewController
                    self.moveToScreen(vc: vc)
                case AppConstants.Screens.SELFIETIME.rawValue:
                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: SelfieViewController.self)) as!  SelfieViewController
                    self.moveToScreen(vc: vc)
                case AppConstants.Screens.VERIFYADDRESS.rawValue:
                    vc = storyBoard.instantiateViewController(withIdentifier: String(describing: VerifyAddressViewController.self)) as!  VerifyAddressViewController
                    self.moveToScreen(vc: vc)
                case AppConstants.Screens.HOME.rawValue:
                    self.moveToHomeScreen()
            default:
                break
            }
        }else{
            self.moveToHomeScreen()
        }
    }
    
    func moveToHomeScreen(){
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        var initialNavigationController:UINavigationController
        sideMenuViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as!  HomeViewController
        initialNavigationController = UINavigationController(rootViewController:homeViewController)
        sideMenuViewController.delegate = homeViewController
        initialNavigationController.navigationBar.makeTransparent()
        containerViewController.leftMenuViewController=sideMenuViewController
        containerViewController.centerViewController=initialNavigationController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeDefault;
        self.window?.rootViewController = containerViewController
        self.window?.makeKeyAndVisible()

    }
    
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

    func applicationWillResignActive(_ application: UIApplication) {
        
        print("applicationWillResignActive")

        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        UserInformationUtility.sharedInstance.deleteCurrentUser()
        RealmHelper.deleteAllFromDatabase()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        self.initialViewController()

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


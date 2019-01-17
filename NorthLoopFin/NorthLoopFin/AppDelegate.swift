//
//  AppDelegate.swift
//  NorthLoopFin
//
//  Created by Daffodil on 03/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sideMenuViewController:SideMenuViewController!
    let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
    var isLoginScreenOpened = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        //Setting up custon navigation controller
        AppLaunchSetup.shareInstance.startMonitoringNetworkRechability()
        AppLaunchSetup.shareInstance.initialiseThirdPartyIfAny()
        sleep(2)
        
        //For Testing only
        UserInformationUtility.sharedInstance.saveUser(islogged: false)
        self.initialViewController()
        return true
    }
    
    func initialViewController() ->Void
    {
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        if (UserInformationUtility.sharedInstance.getUser()){
            var initialNavigationController:UINavigationController

            sideMenuViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as!  HomeViewController
            initialNavigationController = UINavigationController(rootViewController:homeViewController)
            sideMenuViewController.delegate = homeViewController as? SideMenuDelegate
            initialNavigationController.navigationBar.makeTransparent()
            containerViewController.leftMenuViewController=sideMenuViewController
            containerViewController.centerViewController=initialNavigationController
            containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
            containerViewController.shadow.enabled=true;
            containerViewController.panMode = MFSideMenuPanModeDefault;
            self.window?.rootViewController = containerViewController

        }else{
            var initialNavigationController1:UINavigationController

            let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: WelcomeViewController.self)) as!  WelcomeViewController
            
            initialNavigationController1 = UINavigationController(rootViewController:welcomeViewController)
            initialNavigationController1.navigationBar.makeTransparent()
            self.window?.rootViewController = initialNavigationController1

        }
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  ConfirmedNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

class ConfirmedNewViewController: BaseViewController {

    @IBOutlet weak var messageLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.prepareView()
    }
    
    func prepareView(){
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.messageLbl.textColor=Colors.MainTitleColor
        
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.messageLbl.font=AppFonts.btnTitleCalibri18
        self.doneBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
    }
    @IBAction func doneClicked(_ sender: Any) {
        
        UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForScreen)
        RealmHelper.deleteAllFromDatabase()
        let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
        var initialNavigationController:UINavigationController
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sideMenu:SideMenuViewController = (storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController)!
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        initialNavigationController = UINavigationController(rootViewController:homeViewController)
        sideMenu.delegate = homeViewController
        containerViewController.leftMenuViewController=sideMenu
        containerViewController.centerViewController=initialNavigationController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeDefault
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = containerViewController
    }
}

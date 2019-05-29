//
//  TransferSuceessViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

class TransferSuceessViewController: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        self.moveToHomeScreen()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    func prepareView(){
        self.messageLbl.textColor=Colors.MainTitleColor
        
        self.messageLbl.font=AppFonts.mainTitleCalibriBold25
        self.nextBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
    }
    
    func moveToHomeScreen() {
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

//
//  CurrentBalanceViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 16/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

class CurrentBalanceViewController: BaseViewController {

    @IBOutlet weak var addFundsButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightNavigationBar()
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        self.balanceLabel.text = "$"+String(currentUser!.amount)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addFundsButtonAction(_ sender: Any) {
        AppDelegate.getDelegate().isAddFlow = true
    }
    
    @IBAction func transferButtonAction(_ sender: Any) {
        AppDelegate.getDelegate().isAddFlow = false
    }
    
    override func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.openMenu)
        navigationItem.leftBarButtonItem = leftBarItem
    }

    @objc func openMenu(){
        self.menuContainerViewController.setMenuState(MFSideMenuStateLeftMenuOpen, completion: {})
    }
}

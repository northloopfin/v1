//
//  SettingsViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: CommonTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Zorba161149133
        self.customView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    func prepareView(){
        let dataSource:[String] = ["Notification Settings", "App Settings"]
        customView.dataSource = dataSource
        customViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "Settings")
        self.setupRightNavigationBar()
    }
}

//
//  SucessViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SucessViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    @IBAction func okBtnClicked(_ sender: Any) {
        AppUtility.moveToHomeScreen()
    }
    func prepareView(){
        self.setNavigationBarTitle(title: "Set Pin")
        self.setupRightNavigationBar()
    }
    
    
}

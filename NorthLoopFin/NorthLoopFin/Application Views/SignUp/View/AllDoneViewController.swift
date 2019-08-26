//
//  AllDoneViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

class AllDoneViewController: BaseViewController {

    @IBOutlet weak var messageLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
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
        AppUtility.moveToHomeScreen()
    }
}

//
//  LostCardConfirmationViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostCardConfirmationViewController: BaseViewController {

    @IBOutlet weak var messageLbl: LabelWithLetterSpace!
    @IBOutlet weak var okBtn: UIButtonWithSpacing!
    var message:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLbl.text = message
        self.prepareView()
    }
    func prepareView(){
        self.messageLbl.textColor=Colors.MainTitleColor
        
        self.messageLbl.font=AppFonts.btnTitleCalibri18
        self.okBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
    }
    
    @IBAction func okClicked(_ sender: Any) {
        AppUtility.moveToHomeScreen()
    }
}

//
//  ConfirmedViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ConfirmedViewController: BaseViewController {

    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var subTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Confirmed")
        self.prepareView()
    }
    
    func prepareView(){
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.subTitleLbl.textColor=Colors.MainTitleColor
        
        self.subTitleLbl.font=AppFonts.calibri15
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.okBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
    }
}

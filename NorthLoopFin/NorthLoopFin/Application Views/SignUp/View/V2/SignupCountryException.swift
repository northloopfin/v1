//
//  SignupCountryException.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupCountryException: BaseViewController {
    
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
        
        
    }
}

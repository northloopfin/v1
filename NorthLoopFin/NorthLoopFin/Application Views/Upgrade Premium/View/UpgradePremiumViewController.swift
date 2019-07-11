//
//  UpgaredPremiumViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class UpgradePremiumViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var benefitsLbl: LabelWithLetterSpace!
    @IBOutlet weak var messageLbl: LabelWithLetterSpace!
    var presenter:UpgradePresenter!

    
    @IBAction func nextClicked(_ sender: Any) {
        self.presenter.sendUpgradePremiumRequest(sendToAPI: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = UpgradePresenter.init(delegate: self)
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Upgrade")
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.benefitsLbl.textColor = Colors.TaupeGray131130131
        self.messageLbl.textColor = Colors.TaupeGray131130131

        //set font
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.benefitsLbl.font = AppFonts.btnTitleCalibri18
        self.messageLbl.font = AppFonts.calibri15
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
}

extension UpgradePremiumViewController:UpgradeDelegates{
    func didUpgradePremium() {
        
    }
}

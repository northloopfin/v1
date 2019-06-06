//
//  LostCardViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostCardViewController: BaseViewController {
    
    @IBOutlet weak var subTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var sendToBtn1: UIButtonWithSpacing!
    @IBOutlet weak var sendToBtn2: UIButtonWithSpacing!
    
    var presenter:LostCardPresenter!

    @IBAction func expediteClicked(_ sender: Any) {
        self.presenter.sendLostCardRequest(sendToAPI: true)
    }
    
    @IBAction func normalDeliveryClicked(_ sender: Any) {
        self.presenter.sendLostCardRequest(sendToAPI: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LostCardPresenter.init(delegate: self)
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Lost Card")
        self.prepareView()
    }
    
    /// PrepareView by setting up of font and colors
    func prepareView(){
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.subTitleLbl.textColor=Colors.Cameo213186154
        
        self.sendToBtn1.titleLabel?.font=AppFonts.btnTitleCalibri18
        self.sendToBtn2.titleLabel?.font=AppFonts.btnTitleCalibri18
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.subTitleLbl.font=AppFonts.calibri15
    }
}

extension LostCardViewController:LostCardDelegates{
    func didSentLostCardRequest() {
        
    }
}

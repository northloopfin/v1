//
//  PremiumDetailController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 28/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import ZDCChat

class PremiumDetailController: BaseViewController {

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSwitch: RippleButton!
    @IBOutlet weak var lblNextBillingDate: SkyFloatingLabelTextField!
    @IBOutlet weak var lblBillingCycle: SkyFloatingLabelTextField!
    var premiumStatus:PremiumStatus!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        lblBillingCycle.text = premiumStatus.current_plan
        btnSwitch.isHidden = premiumStatus.current_plan.lowercased() == "yearly"
        if let wireDate = AppUtility.getDateObjectFromUTCFormat(dateStr: premiumStatus.validity){
            lblNextBillingDate.text = AppUtility.getDashedDateStringWithoutTime(date: wireDate)
        }
    }
    
    func openChat(){
        ZDCChat.start(in: navigationController, withConfig: nil)
    }
    
    @IBAction func btnCancel_pressed(_ sender: UIButton) {
        openChat()
    }
    
    @IBAction func switch_pressed(_ sender: UIButton) {
        openChat()
    }
}

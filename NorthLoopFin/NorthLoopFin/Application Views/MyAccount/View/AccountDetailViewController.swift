//
//  AccountDetailViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 13/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AccountDetailViewController: BaseViewController {

    @IBOutlet weak var nameLbl: LabelWithLetterSpace!
    @IBOutlet weak var accountNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var rountingNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var swiftNumberLbl: LabelWithLetterSpace!
    
    var presenter:AccountPresenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = AccountPresenter.init(delegate: self)
        self.presenter.sendFetchTransferDetailRequest()


    }
    func prepareView(){
        self.setNavigationBarTitle(title: "Account Details")
        self.setupRightNavigationBar()
        self.nameLbl.textColor = Colors.Taupe776857
        self.accountNumberLbl.textColor = Colors.Taupe776857
        self.rountingNumberLbl.textColor = Colors.Taupe776857
        self.swiftNumberLbl.textColor = Colors.Taupe776857
        
        
        //set font
        self.nameLbl.font = AppFonts.textBoxCalibri16
        self.accountNumberLbl.font = AppFonts.textBoxCalibri16
        self.rountingNumberLbl.font = AppFonts.textBoxCalibri16
        self.swiftNumberLbl.font = AppFonts.textBoxCalibri16
    }
}

extension AccountDetailViewController:UserTransferDetailDelegate{
    func didFetchUserTransactionDetail(data: UserTransferDetailData) {
        let domesticAccountDetails = data.transferDetails.domestic
        let internationalAccountDetails = data.transferDetails.international
        self.nameLbl.text = "Name: "+domesticAccountDetails.bankName
        self.accountNumberLbl.text = "Account No: "+domesticAccountDetails.accountNumber
        self.rountingNumberLbl.text = "Routing No: "+domesticAccountDetails.routing
        self.swiftNumberLbl.text = "Swift No: "+internationalAccountDetails.swift
    }
    
}

//
//  AccountDetailViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 13/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import AlertHelperKit

class AccountDetailViewController: BaseViewController {

    @IBOutlet weak var nameLbl: LabelWithLetterSpace!
    @IBOutlet weak var accountNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var rountingNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var swiftNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var shareBtn: CommonButton!
    var presenter:AccountPresenter!
    var shareAccountDetailsPresenter : ShareAccountDetailsPresenter!

    @IBAction func shareClicked(_ sender: Any) {
        let params = Parameters(
            title: "",
            message: AppConstants.ErrorMessages.FIRST_TIME_LAND_HOME_MESSAGE.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Done"],
            inputFields: [InputField(placeholder: "Enter Email", secure: false)]
        )
        let alert = AlertHelperKit()
        alert.showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                
                if let textFields = alert.textFields {
                    // username
                    let emailEntered: UITextField = textFields[0] as! UITextField
                    self.shareAccountDetailsPresenter.sendShareAccountDetailsRequest(email: emailEntered.text!)
                    // not decided yet ...what to do with this
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = AccountPresenter.init(delegate: self)
        self.presenter.sendFetchTransferDetailRequest()
        self.shareAccountDetailsPresenter = ShareAccountDetailsPresenter.init(delegate: self)
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
extension AccountDetailViewController:ShareAccountDetailDelegates{
    func didSharedAccounTDetails() {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.ACCOUNT_DETAIL_SAHRED_SUCCESSFULLY.rawValue)
    }
}

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

    @IBOutlet weak var bankName: UITextView!
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
    }
}

extension AccountDetailViewController:UserTransferDetailDelegate{
    func didFetchUserTransactionDetail(data: UserTransferDetailData) {
        let domesticAccountDetails = data.transferDetails.domestic
        let internationalAccountDetails = data.transferDetails.international
        self.bankName.text = domesticAccountDetails.bankName
        self.accountNumberLbl.attributedText = getAttributed(title: "Account No", value: domesticAccountDetails.accountNumber)
        self.rountingNumberLbl.attributedText = getAttributed(title:"Routing No", value: domesticAccountDetails.routing)
        self.swiftNumberLbl.attributedText = getAttributed(title:"Swift No", value: internationalAccountDetails.swift)
    }
    
    func getAttributed(title:String, value:String) -> NSMutableAttributedString{
        let str = NSAttributedString(
            string: title + " :  ",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: AppFonts.calibri14
            ]
        )
        let str2 = NSAttributedString(
            string: value,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: AppFonts.calibriBold16
            ]
        )
        
        let combination = NSMutableAttributedString()
        combination.append(str)
        combination.append(str2)
        return combination
    }
    
}
extension AccountDetailViewController:ShareAccountDetailDelegates{
    func didSharedAccounTDetails() {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.ACCOUNT_DETAIL_SAHRED_SUCCESSFULLY.rawValue)
    }
}

//
//  ChangePasswordController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ChangePasswordController: BaseViewController {

    @IBOutlet weak var btnSend: RippleButton!
    var resetPresenter:ResetPasswordPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Change password")
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSend_pressed(_ sender: UIButton) {
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        if let email = currentUser?.userEmail{
            self.resetPresenter.sendResetPasswordRequesy(username: email)
        }
    }
}



extension ChangePasswordController: ResetPasswordDelegate{
    func didSentResetPasswordRequest(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.RESET_EMAIL_SENT.rawValue)
    }
}

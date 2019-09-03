//
//  ConfirmUpgradeController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 26/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ConfirmUpgradeController: BaseViewController {
    @IBOutlet weak var btnConfirmUpgrade: RippleButton!
    @IBOutlet weak var lblUpgradeAmount: UILabel!
    @IBOutlet weak var lblUpgradeType: UILabel!
    @IBOutlet weak var vwInsufficientFund: UIView!
    @IBOutlet weak var vwSuccess: UIView!

    var presenter:UpgradePresenter!
    var isMonthly:Bool = false
    var accountInfoPresenter : AccountInfoPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        prepareView()
    }

    func prepareView() {
        self.presenter = UpgradePresenter.init(delegate: self)
        lblUpgradeAmount.text = isMonthly ? AppConstants.UPGRADETYPE.MONTHLY.rawValue:AppConstants.UPGRADETYPE.ANNUALLY.rawValue
        lblUpgradeType.text = isMonthly ? "MONTHLY":"ANNUALLY"
    }
    
    @IBAction func upgrade_clicked(_ sender: UIButton) {
//        self.vwInsufficientFund.isHidden = false
        sender.isEnabled = false
        self.presenter.sendUpgradePremiumRequest(isMonthly: isMonthly)
    }
    
    @IBAction func contiune_clicked(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension ConfirmUpgradeController:UpgradeDelegates{
    func didUpgradePremium() {
        logEventsHelper.logEventWithName(name: "Upgrade", andProperties: ["Event": "Subscribe Successful"])
        self.vwSuccess.isHidden = false
        accountInfoPresenter = AccountInfoPresenter.init(delegate: self)
        accountInfoPresenter.getAccountInfo()
    }
    
    func didFailedUpgradePremium() {
        btnConfirmUpgrade.isEnabled = true
    }
}

extension ConfirmUpgradeController:HomeDelegate{
    func didFetchedTransactionList(data: [TransactionListModel]) {
    }
    func didFetchedError(error:ErrorModel){
    }
    func didFetchedAccountInfo(data:Account){
        if let premium = data.data.premiumStatus{
            let sideMenu = self.menuContainerViewController.leftMenuViewController as! SideMenuViewController
            sideMenu.premiumStatus = premium
        }
    }
}

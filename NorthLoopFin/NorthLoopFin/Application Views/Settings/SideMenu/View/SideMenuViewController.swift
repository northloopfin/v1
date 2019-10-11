//
//  SideMenuViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

class SideMenuViewController: UIViewController {
    var data:[String]=[]
    
    @IBOutlet weak var optionsTableView: UITableView!
    var cardAuthData:CardAuthData?
    var premiumStatus:PremiumStatus?

    @IBAction func crossClicked(_ sender: Any) {
        closeMenu()
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        logEventsHelper.logEventWithName(name: "Settings", andProperties: ["Event": "User clicks and lands on Settings page"])
        self.moveToScreen(screen: AppConstants.SideMenuOptions.SETTINGS)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewData()
        self.configureTableView()
        self.optionsTableView.reloadData()
    }
    
    func prepareViewData(){
        self.data.append(AppConstants.SideMenuOptions.MYCARD.rawValue)
        self.data.append(AppConstants.SideMenuOptions.TRANSFER.rawValue)
        self.data.append(AppConstants.SideMenuOptions.MYACCOUNT.rawValue)
        self.data.append(AppConstants.SideMenuOptions.PREMIUM.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.EXPENSES.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.CURRENCYPROTECT.rawValue)
        self.data.append(AppConstants.SideMenuOptions.HELP.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.FEEDBACK.rawValue)
        self.data.append(AppConstants.SideMenuOptions.REFER.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.CREDITCARD.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.ADDFUNDTRANSFER.rawValue)
    }
}

extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.optionsTableView.rowHeight = 62;
        self.optionsTableView.delegate=self
        self.optionsTableView.dataSource=self
        self.optionsTableView.registerTableViewCell(tableViewCell: SideMenuTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableCell") as! SideMenuTableCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.PurpleColor17673149
        cell.selectedBackgroundView = backgroundView
        cell.bindData(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 62.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuTableCell
        cell.menuOptionLbl.textColor = Colors.Taupe776857
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuTableCell
        cell.menuOptionLbl.textColor = .white
        switch  (indexPath as NSIndexPath).row {
            case 0:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.MYCARD)
            case 1:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.TRANSFER)
            case 2:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.MYACCOUNT)
            case 3:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.PREMIUM)
//            case 4:
//                self.moveToCurrencyProtect()
            case 4:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.HELP)
            case 5:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.REFER)
            case 6:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.CREDITCARD)
            case 7:
                self.moveToScreen(screen: AppConstants.SideMenuOptions.ADDFUNDTRANSFER)
            default:
                break
        }
    }
    
    func navigateTo(vc:UIViewController){
        closeMenu()
        let center = self.menuContainerViewController.centerViewController as! HomeTabController
        (center.selectedViewController as! UINavigationController).pushViewController(vc, animated: false)
    }
}


extension SideMenuViewController{
    func closeMenu() {
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
    }
    
    func moveToScreen(screen: AppConstants.SideMenuOptions) {
        switch screen {
        case .MYCARD:
            self.navigateToMyCard()
        case .HELP:
            self.navigateToHelp()
        case .TRANSFER:
            self.navigateToAddFund() //navigateToTransfer()
        case .MYACCOUNT:
            self.navigateToMyAccount()
        case .PREMIUM:
            self.navigateToUpgrade()
        case .SETTINGS:
            self.navigateToSettings()
        case .FEEDBACK:
            self.navigateToFeedback()
        case .REFER:
            self.navigateReferAndEarn()
        case .CREDITCARD:
            self.navigateToCreditCard()
        case .ADDFUNDTRANSFER:
            self.navigateToAddFund()
        default:
            break
        }
    }

    func moveToCurrencyProtect(){
        self.navigateTo(vc: getControllerWithIdentifier("CurrencyProtectController"))
    }

    func moveToTesting(){
        self.navigateTo(vc: getControllerWithIdentifier("PersonalDetailViewController"))
    }
    func moveToWaitList(){
        self.navigateTo(vc: getControllerWithIdentifier("WaitListViewController"))
    }
    func navigateToMyCard(){
       let cardViewController = getControllerWithIdentifier("MyCardViewController") as! MyCardViewController
        cardViewController.cardAuthData = self.cardAuthData
        self.navigateTo(vc: cardViewController)
    }
    func navigateToSettings(){
        self.navigateTo(vc: getControllerWithIdentifier("SettingsViewController"))
    }
    func navigateToTransfer(){
        self.navigateTo(vc: getControllerWithIdentifier("MakeTransferViewController"))
    }
    func navigateToMyAccount(){
        self.navigateTo(vc: getControllerWithIdentifier("MyAccountViewController"))
    }
    func navigateToCreditCard(){
        self.navigateTo(vc: getControllerWithIdentifier("ApplyCreditCardVC"))
    }
    func navigateToAddFund(){
        self.navigateTo(vc: getControllerWithIdentifier("CurrentBalanceViewController"))
    }
    func navigateToUpgrade(){
        if premiumStatus != nil && premiumStatus!.current_plan.count > 0{
            let vc = getControllerWithIdentifier("PremiumDetailController") as! PremiumDetailController
            vc.premiumStatus = premiumStatus
            self.navigateTo(vc: vc)
        }else{
            self.navigateTo(vc: getControllerWithIdentifier("CarouselViewComtroller"))
        }
    }
    func navigateToHelp(){
        self.navigateTo(vc: getControllerWithIdentifier("HelpViewController"))
    }
    func navigateToFeedback(){
        guard let url = URL(string: "https://docs.google.com/forms/d/16fBuC42DLWnVZubL-wPTOTTEXc876jIqG4rglnuW4A4/edit") else { return }
        UIApplication.shared.open(url)
    }
    func navigateReferAndEarn(){
        let referAndEarnViewController = ReferAndEarnViewController.init(nibName: "ReferAndEarnViewController", bundle: nil)
        let center = self.menuContainerViewController.centerViewController as! HomeTabController
        (center.selectedViewController as! UINavigationController).present(referAndEarnViewController, animated: true, completion: nil)
    }
}

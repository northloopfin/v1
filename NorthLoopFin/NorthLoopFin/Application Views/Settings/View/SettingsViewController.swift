//
//  SettingsViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import AlertHelperKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveBtn: CommonButton!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    
    var data:[MyCardOtionsModel]=[]
    var getSettingsPresenter : GetAppSettingsPresenter!
    var setSettingsPresenter: SetAppSettingsPresenter!
    var checkUpdatePresenter: CheckUpdatePresenter!

    var isLowAlertOn:Bool = false
    var isTransactionOn:Bool = false
    var isDealsOffersOn:Bool = false
    
    @IBAction func saveClicked(_ sender: Any) {
        self.setSettingsPresenter.sendSaveAppSettingsRequest(isTransactionOn: self.isTransactionOn, isLowBalanceOn: self.isLowAlertOn, isDealOfferOn: self.isDealsOffersOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.optionsTableView.reloadData()
        self.getSettingsPresenter = GetAppSettingsPresenter.init(delegate: self)
        self.setSettingsPresenter = SetAppSettingsPresenter.init(delegate: self)
        self.checkUpdatePresenter = CheckUpdatePresenter.init(delegate: self)
        self.getSettingsPresenter.sendGetAppSettingsRequest()
    }
    
    func prepareView(){
        let option1 = MyCardOtionsModel.init(AppConstants.SettingsOptions.LOWBALANCEALERT.rawValue, isSwitch: true,isSelected: false)
        let option2 = MyCardOtionsModel.init(AppConstants.SettingsOptions.TRANSACTIONALERT.rawValue, isSwitch: true, isSelected: false)
        let option3 = MyCardOtionsModel.init(AppConstants.SettingsOptions.DEALSOFFERS.rawValue, isSwitch: true, isSelected: false)
        let option4 = MyCardOtionsModel.init(AppConstants.SettingsOptions.CHECKFORUPDATE.rawValue, isSwitch: false, isSelected: true)
        data.append(option1)
        data.append(option2)
        data.append(option3)
        data.append(option4)
        customViewHeightConstraint.constant = CGFloat(data.count*70)
        
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.PurpleColor17673149
        self.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        self.setNavigationBarTitle(title: "Settings")
        self.setupRightNavigationBar()
        self.configureTableView()
    }
}

extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.optionsTableView.rowHeight = 70;
        self.optionsTableView.delegate=self
        self.optionsTableView.dataSource=self
        self.optionsTableView.registerTableViewCell(tableViewCell: MyCardTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyCardTableCell = tableView.dequeueReusableCell(withIdentifier: "MyCardTableCell") as! MyCardTableCell
        cell.lock.tag = indexPath.row
        cell.delegate=self
        cell.bindData(data: data[indexPath.row], delegate: self)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            //Check for update clicked.. call api to check
            self.checkForAppUpdate()
        }
    }
    
    func checkForAppUpdate(){
        self.checkUpdatePresenter.sendCheckUpdateCall()
    }
}

extension SettingsViewController:MyCardTableCellDelegate{
    func switchClicked(isOn: Bool, tag: Int) {
        print(isOn)
        switch tag {
        case 0:
            self.isLowAlertOn=isOn
            //Low Balance
        case 1:
            self.isTransactionOn=isOn
            //Transaction
        case 2:
            self.isDealsOffersOn=isOn
            //Deal and Offers
        default:
            break
        }
    }
}

extension SettingsViewController:SettingsDelegates{
    func didCheckUpdate(data: CheckUpdateResponse) {
        let versionOnAppStore = data.appVersion
        if AppConstants.appVersion != versionOnAppStore{
            //versions are not matching check for version now
            if let appversion = AppConstants.appVersion, data.appVersion > appversion{
                // Update is available
                self.showAlert()
            }
        }else{
            //app is upto date
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.APP_IS_UPTO_DATE.rawValue)
        }
    }
    
    func didSaveAppSettings() {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: "Saved")
    }
    
    func didGetAppSettings(data:GetPreferencesData){
        // Change UI here
        self.data = []
        self.data.append(MyCardOtionsModel.init(AppConstants.SettingsOptions.LOWBALANCEALERT.rawValue, isSwitch: true,isSelected: data.lowBalance))
        self.data.append(MyCardOtionsModel.init(AppConstants.SettingsOptions.TRANSACTIONALERT.rawValue, isSwitch: true,isSelected: data.transaction))
        self.data.append(MyCardOtionsModel.init(AppConstants.SettingsOptions.DEALSOFFERS.rawValue, isSwitch: true,isSelected: data.dealsOffers))
        self.data.append(MyCardOtionsModel.init(AppConstants.SettingsOptions.CHECKFORUPDATE.rawValue, isSwitch: false,isSelected: data.dealsOffers))
        self.optionsTableView.reloadData()
    }
    
    func showAlert(){
       let params  = Parameters(
                title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
                message: AppConstants.ErrorMessages.NEWER_VERSION_AVAILABLE.rawValue,
                cancelButton: "Cancel",
                otherButtons: ["Update"]
            )
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                let urlString:String = AppConstants.AppStoreUrl
                if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }

                break
            }
        }
    }
}



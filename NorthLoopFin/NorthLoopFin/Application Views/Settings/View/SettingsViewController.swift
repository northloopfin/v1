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
    var saveSettingsPresenter : GetAppSettingsPresenter!

    
    @IBAction func saveClicked(_ sender: Any) {
        //self.saveSettingsPresenter.sendSaveAppSettingsRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.optionsTableView.reloadData()
        self.saveSettingsPresenter = GetAppSettingsPresenter.init(delegate: self)

    }
    
    override func viewDidLayoutSubviews() {
//        let shadowOffst = CGSize.init(width: 0, height: -55)
//        let shadowOpacity = 0.1
//        let shadowRadius = 49
//        let shadowColor = Colors.Zorba161149133
//        self.customView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    func prepareView(){
        let option1 = MyCardOtionsModel.init(AppConstants.SettingsOptions.LOWBALANCEALERT.rawValue, isSwitch: true,isSelected: true)
        let option2 = MyCardOtionsModel.init(AppConstants.SettingsOptions.TRANSACTIONALERT.rawValue, isSwitch: true, isSelected: true)
        let option3 = MyCardOtionsModel.init(AppConstants.SettingsOptions.DEALSOFFERS.rawValue, isSwitch: true, isSelected: true)
        let option4 = MyCardOtionsModel.init(AppConstants.SettingsOptions.CHECKFORUPDATE.rawValue, isSwitch: true, isSelected: true)
        data.append(option1)
        data.append(option2)
        data.append(option3)
        data.append(option4)
        customViewHeightConstraint.constant = CGFloat(data.count*70)
        
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Zorba161149133
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
}

extension SettingsViewController:MyCardTableCellDelegate{
    func switchClicked(isOn: Bool, tag: Int) {
        
        switch tag {
        case 0: break
            //lock you card
        case 1: break
            
        case 2: break
            
        case 3: break
            // spend abroad
            
            
        default:
            break
        }
    }
}

extension SettingsViewController:SettingsDelegates{
    func didSaveAppSettings() {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.ACCOUNT_DETAIL_SAHRED_SUCCESSFULLY.rawValue)
    }
}



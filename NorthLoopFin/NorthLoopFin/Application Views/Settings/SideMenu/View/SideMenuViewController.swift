//
//  SideMenuViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    var data:[String]=[]
    
    @IBOutlet weak var optionsTableView: UITableView!
    var delegate:SideMenuDelegate!
    
    @IBAction func crossClicked(_ sender: Any) {
        self.delegate.closeMenu()
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.SETTINGS)
        
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
        //self.data.append(AppConstants.SideMenuOptions.UPGRADE.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.EXPENSES.rawValue)
        self.data.append(AppConstants.SideMenuOptions.HELP.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.FEEDBACK.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.PREMIUM.rawValue)
//        self.data.append(AppConstants.SideMenuOptions.REFER.rawValue)
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
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.MYCARD)
            case 1:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.TRANSFER)
            case 2:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.MYACCOUNT)
            case 3:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.HELP)
//            case 4:
//                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.REFER)
//            case 5:
//                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.FEEDBACK)
            default:
                break
        }
    }
}

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewData()
        self.configureTableView()
        self.optionsTableView.reloadData()
    }

    
    func prepareViewData(){
        self.data.append("My Card")
        self.data.append("Settings")
        self.data.append("Transfer")
        self.data.append("My Account")
        self.data.append("Goals")
        self.data.append("Expenses")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  (indexPath as NSIndexPath).row {
            case 0:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.MYCARD)
            case 1:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.SETTINGS)
            case 2:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.TRANSFER)
            case 3:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.MYACCOUNT)
            case 4:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.GOALS)
            case 5:
                self.delegate.moveToScreen(screen: AppConstants.SideMenuOptions.EXPENSES)
        
            default:
                break
        }
    
    }
}

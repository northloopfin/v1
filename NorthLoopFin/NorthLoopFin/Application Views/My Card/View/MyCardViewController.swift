//
//  MyCardViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class MyCardViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    var presenter: CardsPresenter!

    var data:[MyCardOtionsModel]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.prepareViewData()
        self.configureTableView()
        self.optionsTableView.reloadData()
        self.presenter = CardsPresenter.init(delegate: self)
        self.getCardStatus()
    }
    
    
    /// Prepare options data for screen
    func prepareViewData(){
        let option1 = MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: false)
        let option2 = MyCardOtionsModel.init("Report Lost or Stolen", isSwitch: false, isSelected: false)
        let option3 = MyCardOtionsModel.init("Set a New PIN", isSwitch: false, isSelected: false)
       // let option4 = MyCardOtionsModel.init("Spend Abroad", isSwitch: true, isSelected: :false)
        let option4 = MyCardOtionsModel.init("Spend Abroad", isSwitch: true, isSelected: false)
        data.append(option1)
        data.append(option2)
        data.append(option3)
        data.append(option4)
    }
    
    
    /// Prepare view by adding shadow and custom navigation options
    func prepareView(){
        //set shadow to container view
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Zorba161149133
        self.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        self.setNavigationBarTitle(title: "My Card")
        self.setupRightNavigationBar()
    }
    
    func getCardStatus(){
        self.presenter.getCardStatus()
    }
}

extension MyCardViewController:UITableViewDelegate,UITableViewDataSource{
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
        cell.bindData(data: data[indexPath.row])
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
        switch indexPath.row {
        case 0:
            print("Zero")
        case 1:
            self.moveToLostCardScreen()
        default:
              break
        }
    }
    
    func moveToLostCardScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LostCardViewController") as! LostCardViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}

extension MyCardViewController:CardDelegates{
    func didFetchCardStatus(data:Card) {
        if (data.data.status == "ACTIVE"){
        self.data[0] = MyCardOtionsModel.init("Lock Your Card", isSwitch: true, isSelected: true)
        }else{
            self.data[0] = MyCardOtionsModel.init("Lock Your Card", isSwitch: true, isSelected: false)
        }
        self.optionsTableView.reloadData()
    }
}

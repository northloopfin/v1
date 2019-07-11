//
//  MyCardViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import AlertHelperKit

class MyCardViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    var presenter: CardsPresenter!
    var updatePresenter: UpdateCardPresenter!


    var data:[MyCardOtionsModel]=[]
    var isLockCard:Bool = false
    var isSpendAbroad:Bool = false
    var dailyATMWithdrawalLimit:Int = 0
    var dailyTransactionLimit:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.prepareViewData()
        self.configureTableView()
        self.optionsTableView.reloadData()
        self.presenter = CardsPresenter.init(delegate: self)
        self.updatePresenter = UpdateCardPresenter.init(delegate: self)
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
        let shadowColor = Colors.PurpleColor17673149
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
        switch indexPath.row {
        case 0:
            print("Zero")
        case 1:
            self.moveToLostCardScreen()
        case 2:
            self.moveToNewPincreen()
        default:
              break
        }
    }
    
    func moveToLostCardScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LostCardViewController") as! LostCardViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func moveToNewPincreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "NewPinViewController") as! NewPinViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}

extension MyCardViewController:CardDelegates{
    func didFetchCardStatus(data:Card) {
        print(data.data.status)
        self.dailyTransactionLimit = data.data.preferences.dailyTransactionLimit
        self.dailyATMWithdrawalLimit = data.data.preferences.dailyATMWithdrawalLimit
        self.isSpendAbroad = data.data.preferences.allowForeignTransactions
        
        if (data.data.status == "ACTIVE"){
            self.isLockCard = false
            self.data = []
        self.data.append(MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: self.isLockCard))
        self.data.append(MyCardOtionsModel.init("Report Lost or Stolen", isSwitch: false,isSelected: false))
        self.data.append(MyCardOtionsModel.init("Set a New PIN", isSwitch: false,isSelected: false))
        self.data.append(MyCardOtionsModel.init("Spend Abroad", isSwitch: true,isSelected: self.isSpendAbroad))

                self.optionsTableView.reloadData()
            
        }else{
            self.isLockCard = true
            
        }
        
    }
}

extension MyCardViewController:UpdateCardDelegates{
    func didUpdateCardStatus(data: Card) {
        //Nothing to do here. May be in futur ewe can use this function to update UI
    }
}

extension MyCardViewController:MyCardTableCellDelegate{
    func switchClicked(isOn: Bool, tag: Int) {
        if self.isLockCard{
            self.data = []
            self.prepareViewData()
            self.optionsTableView.reloadData()
            self.showAlertForInactiveCadrs()
            return
        }
        switch tag {
        case 0:
            //lock you card
            self.isLockCard=isOn
            self.showConfirmationAlert()
            
        case 3:
            // spend abroad
            self.isSpendAbroad=isOn
            self.showConfirmationAlert()
        
        default:
            break
        }
    }
    
    func showConfirmationAlert(){
        var params = Parameters(
            title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
            message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_LOCK_CARD.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Confirmed"]
        )
        if self.isSpendAbroad{
            params = Parameters(
                title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
                message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_SPEND_ABROAD.rawValue,
                cancelButton: "Cancel",
                otherButtons: ["Confirmed"]
            )
        }
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                self.createRequestForUpdateCardStatus()
            }
        }
    }
    
    
    func createRequestForUpdateCardStatus(){
        let preference = UpdateCardPreferenceBody.init(allowForeignTransactions: self.isSpendAbroad, dailyATMWithdrawalLimit: self.dailyATMWithdrawalLimit, dailyTransactionLimit: self.dailyTransactionLimit)
        var card = UpdateCardRequestBody.init(status: "ACTIVE", pre: preference)
        if self.isLockCard{
            card = UpdateCardRequestBody.init(status: "INACTIVE", pre: preference)
        }
        
        self.updatePresenter.updateCardStatus(requestBody: card)
    }
    
    // Show alert for inactive card
    func showAlertForInactiveCadrs(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.CARD_NOT_ACTIVE_YET.rawValue)
    }
}

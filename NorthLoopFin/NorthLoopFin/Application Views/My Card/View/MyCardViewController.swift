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
    var authPresenter: CardAuthPresenter!
    var infoPresenter: CardInfoPresenter!
    var updatePresenter: UpdateCardPresenter!

    @IBOutlet weak var nameOnCard: UILabel!
    @IBOutlet weak var validThrough: UILabel!
    @IBOutlet weak var cvv: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
    @IBOutlet weak var whatsThisButton: UIButton!
    //    @IBOutlet weak var btnWhatsThis: UIButton!
    @IBOutlet weak var vwActivateCard: UIView!
    @IBOutlet weak var vwWhatsThis: UIView!
    @IBOutlet weak var vwVirtualCard: UIView!
    var data:[MyCardOtionsModel]=[]
    var isLockCard:Bool = false
    var isSpendAbroad:Bool = false
    var dailyATMWithdrawalLimit:Int = 0
    var dailyTransactionLimit:Int = 0
    var cardAuthData: CardAuthData?
    var cardInfoData: CardInfo?
    var cardActivated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.prepareViewData()
        self.prepareWhatsThisView()
        self.configureTableView()
        self.optionsTableView.reloadData()
        self.presenter = CardsPresenter.init(delegate: self)
        self.updatePresenter = UpdateCardPresenter.init(delegate: self)
        self.infoPresenter = CardInfoPresenter.init(delegate: self)
        self.authPresenter = CardAuthPresenter.init(delegate: self)
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        cardActivated = currentUser!.cardActivated
        self.getCardStatus()
        self.vwActivateCard.cornerRadius = 4
    }
    
    
    /// Prepare options data for screen
    func prepareViewData(){
        let option1 = MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: false)
        let option2 = MyCardOtionsModel.init("Report Lost or Stolen", isSwitch: false, isSelected: false)
        let option3 = MyCardOtionsModel.init("Set a New PIN", isSwitch: false, isSelected: false)
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

    func prepareWhatsThisView(){
        //set shadow to container view
        let shadowOffst = CGSize.init(width: 0, height: 5)
        let shadowOpacity = 0.5
        let shadowRadius = 5
        let shadowColor = UIColor.init(red: 205, green: 205, blue: 205)
        self.vwWhatsThis.layer.addShadowAndRoundedCorners(roundedCorner: 6.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }

    func getCardStatus(){
        if cardActivated == true{
            self.presenter.getCardStatus()
        }else{
            self.vwActivateCard.isHidden = false
        }
    }
    
    func getCardAuth(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.authPresenter.getCardAuth()
        }
    }
    
    func getCardInfo(){
        if cardActivated == true{
            if let card = AppDelegate.getDelegate().cardInfo {
                self.didFetchCardInfo(data: card)
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.infoPresenter.getCardInfo(cardAuthData: self.cardAuthData!)
                }
            }
        }else{
            self.vwActivateCard.isHidden = false
        }
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        vwWhatsThis.isHidden = true
    }

    @IBAction func whatsClicked(_ sender: Any) {
        vwWhatsThis.isHidden = false
    }
    
    @IBAction func cardActivateClicked(_ sender: UIButton) {
        self.vwVirtualCard.isUserInteractionEnabled = false
         let preference = UpdateCardPreferenceBody.init(allowForeignTransactions: true, dailyATMWithdrawalLimit: self.dailyATMWithdrawalLimit, dailyTransactionLimit: self.dailyTransactionLimit)
        let card = UpdateCardRequestBody.init(status: "ACTIVE", pre: preference)
        self.updatePresenter.updateCardStatus(requestBody: card, firstTimeActivate: true)
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
        if cardActivated == false{
            self.showAlertForActiveCard()
            return
        }
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
//        if self.isLockCard{
//            self.showAlertForInactiveCadrs()
//            return
//        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LostCardViewController") as! LostCardViewController
            self.navigationController?.pushViewController(transactionDetailController, animated: false)
//        }
        
    }
    func moveToNewPincreen() {
        if self.isLockCard{
            self.showAlertForInactiveCadrs()
            return
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "NewPinViewController") as! NewPinViewController
            self.navigationController?.pushViewController(transactionDetailController, animated: false)
        }
    }
}

extension MyCardViewController:CardDelegates{
    func didFetchCardStatus(data:Card) {
    
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        if currentUser?.cardActivated == false{
            currentUser?.cardActivated = true
            UserInformationUtility.sharedInstance.saveUser(model: currentUser!)
        }
        
        self.vwVirtualCard.isUserInteractionEnabled = true
        self.vwActivateCard.isHidden = true
        print(data.data.status)
        self.dailyTransactionLimit = data.data.preferences.dailyTransactionLimit
        self.dailyATMWithdrawalLimit = data.data.preferences.dailyATMWithdrawalLimit
        self.isSpendAbroad = data.data.preferences.allowForeignTransactions
        
        if (data.data.status == "ACTIVE") {
            self.isLockCard = false
            self.data = []
        self.data.append(MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: self.isLockCard))
        self.data.append(MyCardOtionsModel.init("Report Lost or Stolen", isSwitch: false,isSelected: false))
        self.data.append(MyCardOtionsModel.init("Set a New PIN", isSwitch: false,isSelected: false))
        self.data.append(MyCardOtionsModel.init("Spend Abroad", isSwitch: true,isSelected: self.isSpendAbroad))
        self.optionsTableView.reloadData()
        } else if data.data.status == "PENDING" {
            self.isLockCard = true
        } else if data.data.status == "INACTIVE" {
            self.isLockCard = true
            self.data = []
            self.data.append(MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: self.isLockCard))
            self.data.append(MyCardOtionsModel.init("Report Lost or Stolen", isSwitch: false,isSelected: false))
            self.optionsTableView.reloadData()
        }
        
        if self.cardNumber.text!.isEmpty{
            if self.cardAuthData == nil {
                self.getCardAuth()
            } else {
                self.getCardInfo()
            }
        }
    }
}

extension MyCardViewController:CardAuthDelegates{
    func didFetchCardAuth(data: CardAuthData) {
        self.cardAuthData = data
        self.getCardInfo()
    }
}

extension MyCardViewController:CardInfoDelegates{
    func didFetchCardInfo(data: CardInfo) {
        AppDelegate.getDelegate().cardInfo = data
        self.nameOnCard.text = data.nickname
        self.cvv.text = data.cvc
        self.validThrough.text = data.exp
        self.cardNumber.text = modifyCreditCardString(creditCardString: data.card_number)
        let parts = data.exp.components(separatedBy: "-")
        if parts.count == 3 {
            self.validThrough.text = parts[1] + "/" + (parts[0]).suffix(2)
        }
        self.vwVirtualCard.isHidden = false
        self.whatsThisButton.isHidden = false
        self.vwActivateCard.isHidden = true
        
        if !self.cardActivated {
            self.cardActivated = true
            self.moveToNewPincreen()
        }

    }
    
    func modifyCreditCardString(creditCardString : String) -> String
    {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        let arrOfCharacters = Array(trimmedString.characters)
        
        var modifiedCreditCardString = ""
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count)
                {
                
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
}

extension MyCardViewController:UpdateCardDelegates{
    func didUpdateCardStatus(data: Card) {
        self.didFetchCardStatus(data: data)
        //Nothing to do here. May be in futur ewe can use this function to update UI
    }
}

extension MyCardViewController:MyCardTableCellDelegate{
    func switchClicked(isOn: Bool, tag: Int) {
        if cardActivated == false{
            self.data[0] = (MyCardOtionsModel.init("Lock Your Card", isSwitch: true,isSelected: false))
            self.data[3] = (MyCardOtionsModel.init("Spend Abroad", isSwitch: true,isSelected: false))
            self.optionsTableView.reloadData()
            self.showAlertForActiveCard()
            return
        }

        switch tag {
        case 0:
            //lock you card
            self.isLockCard = isOn
            if self.isLockCard {
                self.showConfirmationAlertForLockCard()
            } else {
                self.createRequestForUpdateCardStatus()
            }
            
        case 3:
            // spend abroad
            self.isSpendAbroad=isOn
            self.showConfirmationAlertForSpendAbroad()
            if self.isLockCard{
                self.data = []
                self.prepareViewData()
                self.optionsTableView.reloadData()
                self.showAlertForInactiveCadrs()
                return
            }
        
        default:
            break
        }
    }
    
    func showConfirmationAlertForLockCard(){
        let paramsForLockCard = Parameters(
            title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
            message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_LOCK_CARD.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Confirm"]
        )
        
        
        AlertHelperKit().showAlertWithHandler(self, parameters: paramsForLockCard) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
                self.isLockCard = false
                self.optionsTableView.reloadData()
            default:
                self.createRequestForUpdateCardStatus()
            }
        }
    }
    
    func showConfirmationAlertForSpendAbroad(){
      let  params = Parameters(
            title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
            message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_SPEND_ABROAD.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Confirm"]
        )
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
                self.isSpendAbroad=false
                self.optionsTableView.reloadData()
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
    
    func showAlertForActiveCard(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ACTIVATE_YOUR_CARD.rawValue)
    }

}

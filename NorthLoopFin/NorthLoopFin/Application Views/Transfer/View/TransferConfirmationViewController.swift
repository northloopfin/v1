//
//  TransferConfirmationViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferConfirmationViewController: BaseViewController {

    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var accountNumberLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var fieldContainer: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter:ACHTransactionPresenter!
    var amount:String = ""
    var ach:ACHNode? = nil
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        // check for minimum balance
        if let currentUser = UserInformationUtility.sharedInstance.getCurrentUser(){
            print(currentUser.amount)
            if (currentUser.amount.isLess(than: Double(self.amount) ?? 0.0)){
                //Insufficient Balance show popup
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.INSUFFICIENT_BALANCE.rawValue)
            }else{
                self.presenter.sendACHTransactionRequest(amount: amount, nodeID: (ach?.nodeID)!)
            }
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = ACHTransactionPresenter.init(delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: 760)
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.nextBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
        self.amountLbl.text = "Amount: $"+self.amount
        self.toLbl.text = "To: " + self.ach!.nickname
        self.accountNumberLbl.text = "Account Number: XXX" + self.ach!.account_num
        self.dateLbl.text =  "Date: " + AppUtility.getFormattedDateFullString(date: Date())
        
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Taupe776857
        self.fieldContainer.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        
        btnCancel.layer.borderColor = Colors.DustyGray155155155.cgColor
        btnCancel.layer.borderWidth = 1
    }
    
}
extension TransferConfirmationViewController:ACHTransactionDelegates{
    func didSentFetchACH() {
        self.moveToSucessScreen()
    }
    
    func moveToSucessScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TransferSuceessViewController") as! TransferSuceessViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

//
//  WireRateController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 07/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Toast_Swift

class WireRateController: BaseViewController {
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClaimRefund: RippleButton!
    @IBOutlet weak var btnEligibleRefund: UIButton!
    @IBOutlet weak var btnBestRate: UIButton!
    @IBOutlet weak var vwNoRefund: UIView!
    @IBOutlet weak var vwAction: UIView!
    
    var transactionID = ""
    var fetchPresenter: FetchWireTransferPresenter?
    var claimPresenter: ClaimRefundPresenter?

    var wireTransfer: WireTransfer? {
        didSet {
            fillData()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.configureTable()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.fetchPresenter = FetchWireTransferPresenter(delegate: self)
        self.fetchPresenter?.sendFetchRequest(transactionID: transactionID)
    
        self.setupRightNavigationBar()
        styleButton(btn: btnBestRate)
        styleButton(btn: btnEligibleRefund)
    }
    
    func fillData(){
        self.vwAction.isHidden = false
        self.setNavigationBarTitle(title: (wireTransfer?.data.transaction.wire_from)!)
        self.lblTotalAmount.text = "$ " + (wireTransfer?.data.transaction.amount)!
        
        let rateString = NSMutableAttributedString(string: "Best rate  ", attributes: [ NSAttributedString.Key.font: AppFonts.calibri15 ] )
        let rate = NSAttributedString(string: "INR " + (wireTransfer?.data.transaction.fav_exchange_rate)!, attributes: [ NSAttributedString.Key.font: AppFonts.calibriBold18 ])
        rateString.append(rate)
        rateString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.AmountGreen241770], range: NSRange(location: 0, length: rateString.length))
        btnBestRate.setAttributedTitle(rateString, for: .normal)
        
        let eligibleString = NSMutableAttributedString(string: "Eligible refund  ", attributes: [ NSAttributedString.Key.font: AppFonts.calibri15 ] )
        let eligible = NSAttributedString(string: "$ " + (wireTransfer?.data.cashbackAmount)!, attributes: [ NSAttributedString.Key.font: AppFonts.calibriBold18 ])
        eligibleString.append(eligible)
        eligibleString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.PurpleColor17673149], range: NSRange(location: 0, length: eligibleString.length))
        btnEligibleRefund.setAttributedTitle(eligibleString, for: .normal)
        if let inr = Double((wireTransfer?.data.cashbackAmount)!), inr > 0{
            btnClaimRefund.isHidden = false
            btnClaimRefund.setTitle("CLAIM REFUND $ " + (wireTransfer?.data.cashbackAmount)!, for: .normal)
        }else{
            vwNoRefund.isHidden = false
        }
    }
    
    func styleButton(btn:UIButton){
         let shadowOffst = CGSize.init(width: 0, height: 1)
         let shadowOpacity = 0.15
         let shadowRadius = 3
         let shadowColor = Colors.DustyGray155155155
         btn.layer.addShadowAndRoundedCorners(roundedCorner: 5, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }

    @IBAction func whyNoRefund_clicked(_ sender: UIButton) {
        self.view.makeToast("Fortunately for you, the currency hasn't changed against you! You sent the money on the best day in the past week", duration: 3.0, position: .bottom)

    }
    
    @IBAction func btnClaimRefund_clicked(_ sender: UIButton) {
        self.claimPresenter = ClaimRefundPresenter(delegate: self)
        self.claimPresenter?.sendClaimRequest(transactionID: transactionID)
    }
}

extension WireRateController:UITableViewDelegate,UITableViewDataSource{
    //Configure table view delgates and data source
    func configureTable(){
        self.tableView.rowHeight = 51;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableViewCell(tableViewCell: WireRateCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wireTransfer != nil{
            return (wireTransfer?.data.pastRates.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WireRateCell = tableView.dequeueReusableCell(withIdentifier: "WireRateCell") as! WireRateCell
        cell.selectionStyle = .none
        cell.bindData(data: (wireTransfer?.data.pastRates[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.tableView.rowHeight
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension WireRateController:FetchWireTransferDelegates{
    func didFetcWireTransfer(data: WireTransfer) {
        wireTransfer = data
    }
}


extension WireRateController:ClaimRefundDelegate{
    func didClaimRefund(data: ClaimRefund) {
        if data.message.count > 0{
            self.showErrorAlert("", alertMessage: data.message)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
}

//
//  WireListController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 07/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class WireListController: BaseViewController {
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClaimRefund: RippleButton!
    @IBOutlet weak var btnEligibleRefund: UIButton!
    @IBOutlet weak var btnBestRate: UIButton!
    
    var transactionDataSource: [String] = ["1","2","3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.configureTable()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Wire transfer 1")
        self.setupRightNavigationBar()
        styleButton(btn: btnBestRate)
        styleButton(btn: btnEligibleRefund)

        let rateString = NSMutableAttributedString(string: "Best rate  " )
        let rate = NSAttributedString(string: "INR 65.00", attributes: [ NSAttributedString.Key.font: AppFonts.calibriBold18 ])
        rateString.append(rate)
        rateString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.AmountGreen241770], range: NSRange(location: 0, length: rateString.length))
        btnBestRate.setAttributedTitle(rateString, for: .normal)

        let eligibleString = NSMutableAttributedString(string: "Eligible Fund  " )
        let eligible = NSAttributedString(string: "INR 65.00", attributes: [ NSAttributedString.Key.font: AppFonts.calibriBold18 ])
        eligibleString.append(eligible)
        eligibleString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.PurpleColor17673149], range: NSRange(location: 0, length: eligibleString.length))
        btnEligibleRefund.setAttributedTitle(eligibleString, for: .normal)
    }
    
    
    func styleButton(btn:UIButton){
         let shadowOffst = CGSize.init(width: 0, height: 1)
         let shadowOpacity = 0.15
         let shadowRadius = 3
         let shadowColor = Colors.DustyGray155155155
         btn.layer.addShadowAndRoundedCorners(roundedCorner: 5, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }


    @IBAction func btnClaimRefund_clicked(_ sender: UIButton) {
    }
}

extension WireListController:UITableViewDelegate,UITableViewDataSource{
    //Configure table view delgates and data source
    func configureTable(){
        self.tableView.rowHeight = 51;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableViewCell(tableViewCell: WireCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WireCell = tableView.dequeueReusableCell(withIdentifier: "WireCell") as! WireCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 51.0
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}




//
//  CashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class CashbackController: BaseViewController {
    
    @IBOutlet weak var vwCashbackDetail: UIView!
    @IBOutlet weak var vwCashbackSummary: UITableView!
    @IBOutlet weak var constSelectionUnderlineLeading: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnRedeem: RippleButton!
    @IBOutlet weak var lblCashbackAmount: UILabel!
    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var btnGeneral: UIButton!
    var fetchPresenter: FetchCashbackPresenter!
    var redeemPresenter: RedeemCashbackPresenter!
    var transactions: [CashbackTransaction] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.configureTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCashbackDetail()
    }

    @IBAction func general_clicked(_ sender: UIButton) {
        sender.titleLabel?.font = AppFonts.calibriBold17
        btnRestaurant.titleLabel?.font = AppFonts.calibri17
        constSelectionUnderlineLeading.constant = 0
    }
    
    @IBAction func restaurant_clicked(_ sender: UIButton) {
        sender.titleLabel?.font = AppFonts.calibriBold17
        btnGeneral.titleLabel?.font = AppFonts.calibri17
        constSelectionUnderlineLeading.constant = sender.frame.origin.x
    }
    
    func prepareView(){
        styleContainer(vw: vwCashbackDetail)
        styleContainer(vw: vwCashbackSummary)
    }
    
    func styleContainer(vw:UIView){
        let shadowOffst = CGSize.init(width: 0, height: 1)
        let shadowOpacity = 0.4
        let shadowRadius = 2
        let shadowColor = Colors.DustyGray155155155
        vw.layer.addShadowAndRoundedCorners(roundedCorner: 5, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)        
    }
    
    
    func getCashbackDetail() {
        self.fetchPresenter = FetchCashbackPresenter.init(delegate: self)
        self.fetchPresenter.sendFetchCashbackRequest()
        self.btnRedeem.isEnabled = false
    }
    
    @IBAction func btnRedeem_pressed(_ sender: UIButton) {
        self.redeemPresenter = RedeemCashbackPresenter.init(delegate: self)
        self.redeemPresenter.sendRedeemCashbackRequest()
        self.btnRedeem.isEnabled = false
    }
}


extension CashbackController: FetchCashbackDelegate{
    func didFetchCashback(data: [CashbackDetail]) {
        if data.count > 0 {
            self.lblCashbackAmount.text = "$" + String(format: "%.2f",data[0].value)
        }
        self.btnRedeem.isEnabled = data.count > 0
    }
}

extension CashbackController: RedeemCashbackDelegate{
    func didRedeemCashback(data: RedeemCashback) {
        self.showAlert(title: "", message: data.data)
        self.lblCashbackAmount.text = "$0"
        self.btnRedeem.isEnabled = false
    }
}
extension CashbackController: UITableViewDelegate,UITableViewDataSource {
    func configureTable(){
        self.tableView.register(UINib(nibName:"CashbackCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CashbackCell")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CashbackCell", for: indexPath) as! CashbackCell
        if indexPath.row == 0 {
            cell.imgPreview.image = UIImage(named: "ic_amazon_prime")
            cell.lblTitle.text = "Amazon Prime Student"
            cell.lblSubTitle.text = "Premium users only"
        }
        if indexPath.row == 1{
            cell.imgPreview.image = UIImage(named: "ic_starbucks")
            cell.lblTitle.text = "Starbucks"
            cell.lblSubTitle.text = "3% cashback on all purchases"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
}


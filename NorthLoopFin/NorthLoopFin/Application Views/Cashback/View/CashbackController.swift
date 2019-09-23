
//
//  CashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import MFSideMenu

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
    var campusPresenter: CampusPresenter!
    var campusStatusPresenter: CampusVoteStatusPresenter!
    var redeemPresenter: RedeemCashbackPresenter!
    
    var transactions: [CashbackTransaction] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var vwCampusVote: UIView!
    @IBOutlet weak var constGeneralTabWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constGeneralTabWidth.constant = self.view.frame.size.width
        self.prepareView()
        self.setupRightNavigationBar()
        self.configureTable()
        logEventsHelper.logEventWithName(name: "Cashback", andProperties: ["Event": "View"])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.makeTransparent()
        getCashbackDetail()
    }

    override func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.openMenu)
        navigationItem.leftBarButtonItem = leftBarItem
    }
 
    @objc func openMenu(){
        self.menuContainerViewController.setMenuState(MFSideMenuStateLeftMenuOpen, completion: {})
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
    
    func getCampusList() {
        self.campusPresenter = CampusPresenter.init(delegate: self)
        self.campusPresenter.sendCampusRequest()
        self.btnRedeem.isEnabled = false
    }

    func getCampusStatus() {
        self.campusStatusPresenter = CampusVoteStatusPresenter.init(delegate: self)
        self.campusStatusPresenter.sendCampusVoteStatusRequest()
        self.btnRedeem.isEnabled = false
    }
    
    @IBAction func general_clicked(_ sender: UIButton) {
        sender.isSelected = true
        btnRestaurant.isSelected = false
        sender.titleLabel?.font = AppFonts.calibriBold16
        btnRestaurant.titleLabel?.font = AppFonts.calibri16
        constSelectionUnderlineLeading.constant = 0
        self.tableView.tag = 0
        self.tableView.isHidden = false
    }
    
    @IBAction func restaurant_clicked(_ sender: UIButton) {
        sender.isSelected = true
        btnGeneral.isSelected = false
        sender.titleLabel?.font = AppFonts.calibriBold16
        btnGeneral.titleLabel?.font = AppFonts.calibri16
        constSelectionUnderlineLeading.constant = sender.frame.origin.x
        self.tableView.tag = 1
        self.tableView.isHidden = true
    }

    @IBAction func btnRedeem_pressed(_ sender: UIButton) {
        logEventsHelper.logEventWithName(name: "Cashback", andProperties: ["Event": "Redeem"])
        self.redeemPresenter = RedeemCashbackPresenter.init(delegate: self)
        self.redeemPresenter.sendRedeemCashbackRequest()
        self.btnRedeem.isEnabled = false
    }
    
    @IBAction func btnVote_pressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(self.getControllerWithIdentifier("CampusCashbackController"), animated: true)

    }
}


extension CashbackController: FetchCashbackDelegate{
    func didFetchCashback(data: [CashbackDetail]) {
        if data.count > 0 {
            self.lblCashbackAmount.text = "$" + String(format: "%.2f",data[0].value)
        }else{
            self.lblCashbackAmount.text = "$0"
        }
        self.btnRedeem.isEnabled = data.count > 0
        getCampusList()
    }
}

extension CashbackController: RedeemCashbackDelegate{
    func didRedeemCashback(data: RedeemCashback) {
        self.toast(message: "You'll see your account credited in a few minutes!")
        self.lblCashbackAmount.text = "$0"
        self.btnRedeem.isEnabled = false
    }
}

extension CashbackController: CampusDelegate{
    func didFetchCampus(data: CampusData) {
        if data.values.count > 0 {
            self.constGeneralTabWidth.constant = self.view.frame.size.width/2
            getCampusStatus()
        }
    }
}

extension CashbackController: CampusVoteStatusDelegate{
    func didCampusVoteStatus(data: CampusVoteStatus) {
        self.vwCampusVote.isHidden = data.data.voted
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
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let url = URL(string: "https://northloop.zendesk.com/hc/en-us/articles/360032248712") else { return }
            UIApplication.shared.open(url)
        }
    }
}


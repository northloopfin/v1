
//
//  CashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import MFSideMenu
import DropDown
import IQKeyboardManagerSwift

class CashbackController: BaseViewController {
    
    @IBOutlet weak var vwCashbackDetail: UIView!
    @IBOutlet weak var vwCashbackSummary: UITableView!
    @IBOutlet weak var constSelectionUnderlineLeading: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tblCampus: UITableView!
    @IBOutlet weak var btnRedeem: RippleButton!
    @IBOutlet weak var lblCashbackAmount: UILabel!
    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var btnGeneral: UIButton!
    var fetchPresenter: FetchCashbackPresenter!
    var campusPresenter: CampusPresenter!
    var campusStatusPresenter: CampusVoteStatusPresenter!
    var redeemPresenter: RedeemCashbackPresenter!
    var status: CampusVoteStatusData! = nil{
        didSet {
            if campusArr.count > 0{
                constVoteNowHeight.constant = status.voted ? 100 : 100
            }
        }
    }
 
    var campusArr:[Campus] = [] {
        didSet {
            self.tblCampus.reloadData()
            if status != nil, campusArr.count > 0{
                constVoteNowHeight.constant = status.voted ? 100 : 100
            }
        }
    }
    let dropDown = DropDown()

    @IBOutlet weak var vwCampusVote: UIView!
    @IBOutlet weak var constGeneralTabWidth: NSLayoutConstraint!
    @IBOutlet weak var constVoteNowHeight: NSLayoutConstraint!
    @IBOutlet weak var txtUniversity: UITextField!
    @IBOutlet weak var constUniversityHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constGeneralTabWidth.constant = self.view.frame.size.width/2
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
        self.campusPresenter = CampusPresenter.init(delegate: self)
    }
    
    func setupUniversityField(){
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.txtUniversity.textColor=Colors.DustyGray155155155
        self.txtUniversity.font=AppFonts.textBoxCalibri16
        self.txtUniversity.applyAttributesWithValues(placeholderText: "University", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.txtUniversity.setLeftPaddingPoints(19)
        
        self.txtUniversity.inputView = UIView.init(frame: CGRect.zero)
        self.txtUniversity.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.txtUniversity.setRightIcon(UIImage.init(named: "chevron")!)
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
    
    func getUniversityList() {
        self.campusPresenter.sendUniversityRequest()
    }
    
    func getCampusList() {
        self.campusPresenter.sendCampusRequest(name: self.txtUniversity.text!)
    }

    func getCampusStatus() {
        self.campusStatusPresenter = CampusVoteStatusPresenter.init(delegate: self)
        self.campusStatusPresenter.sendCampusVoteStatusRequest()
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
        if (campusArr.count == 0){
            self.showAlert(title: "", message: "Please select university")
        }else{
            let vc = self.getControllerWithIdentifier("CampusCashbackController") as! CampusCashbackController
            vc.campusArr = self.campusArr
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CashbackController:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.resignFirstResponder()
        self.dropDown.show()
        return false
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
        if txtUniversity.text?.count == 0 && data.values.count == 0 {
            getUniversityList()
        }else if data.values.count > 0{
            if txtUniversity.text?.count == 0{
                constUniversityHeight.constant = 0
            }
            campusArr = data.values
            getCampusStatus()
        }
    }
    
    func emptyCampus() {
        if txtUniversity.text?.count == 0{
            getUniversityList()
        }
    }
    
    func didFetchUniversities(data: [String]) {
        setupUniversityField()
        constUniversityHeight.constant = 60
        dropDown.anchorView = self.txtUniversity
        dropDown.dataSource = data
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtUniversity.text=item
            self.dropDown.hide()
            self.getCampusList()
        }
        getCampusStatus()
    }
}

extension CashbackController: CampusVoteStatusDelegate{
    func didCampusVoteStatus(data: CampusVoteStatus) {
        status = data.data
    }
}

extension CashbackController: UITableViewDelegate,UITableViewDataSource {
    func configureTable(){
        self.tableView.register(UINib(nibName:"CashbackCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CashbackCell")
        self.tblCampus.register(UINib(nibName:"CampusCashbackCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CampusCashbackCell")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tblCampus ? campusArr.count : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView != self.tblCampus){
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
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CampusCashbackCell", for: indexPath) as! CampusCashbackCell
            cell.bindData(data: campusArr[indexPath.row], selected: false)
            cell.lblCount.text = String(indexPath.row+1)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
            if indexPath.row == 0 {
                guard let url = URL(string: "https://northloop.zendesk.com/hc/en-us/articles/360032248712") else { return }
                UIApplication.shared.open(url)
            }
        }
    }
}


//
//  AddBankController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 10/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AddBankController: BaseViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var btnVerifyContinue: RippleButton!
    @IBOutlet weak var lblEmail: LabelWithLetterSpace!
    @IBOutlet weak var lblPhone: LabelWithLetterSpace!
    @IBOutlet weak var imgBankLogo: UIImageView!
    @IBOutlet weak var vwVerifyAccount: UIView!
    
    var institutionsPresenter:InstitutionsPresenter!
    var topBanks:[clsInstitutions] = []
    var institutionData:InstitutionsData!
    var banks:[Institutions] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    var addAccountPresenter:AccountAggregatePresenter!
    var selectedBank:Institutions!
    var aggregateData:AccountAggregateData!
    var selectedNode:ACHNode!

    @IBOutlet weak var txtSecurityAnswer: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtUserId: SkyFloatingLabelTextField!
    @IBOutlet weak var lblVerificationTitle: LabelWithLetterSpace!
    @IBOutlet weak var vwBankLogin: UIView!
    @IBOutlet weak var vwSecurityQuestion: UIView!
    @IBOutlet weak var lblErrorDescription: LabelWithLetterSpace!
    @IBOutlet weak var vwError: UIView!
    
    @IBOutlet weak var tableAccountSelect: UITableView!
    @IBOutlet weak var vwAccountSelection: UIView!
    @IBAction func textChanged(_ sender: UITextField) {
        if self.vwBankLogin.isHidden {
            self.btnVerifyContinue.isEnabled = txtSecurityAnswer.text!.count > 0
        }else{
            self.btnVerifyContinue.isEnabled = txtUserId.text!.count > 0 && txtPassword.text!.count > 0
        }
    }
    
    @IBOutlet weak var constTableAccountSelect: NSLayoutConstraint!
    @IBOutlet weak var btnConfirm: RippleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        configureTableView()
        configureCollectionView()
        institutionsPresenter = InstitutionsPresenter(delegate: self)
        institutionsPresenter.sendInstitutionsRequest()
        
        topBanks.append(clsInstitutions(name: "Chase", code: "chase", image: "https://cdn.synapsepay.com/bank_logos_v3p1/chase_v.png"))
        topBanks.append(clsInstitutions(name: "Bank of America", code: "bofa", image: "https://cdn.synapsepay.com/bank_logos_v3p1/bankofamerica_v.png"))
        topBanks.append(clsInstitutions(name: "Wells Fargo", code: "wells", image: "https://cdn.synapsepay.com/bank_logos_v3p1/wells fargo_v.png"))
        topBanks.append(clsInstitutions(name: "Citibank", code: "citi", image: "https://cdn.synapsepay.com/bank_logos_v3p1/Citibank_v.png"))
        topBanks.append(clsInstitutions(name: "PNC", code: "pnc", image: "https://cdn.synapsepay.com/bank_logos_v3p1/pnc bank_v.png"))
        topBanks.append(clsInstitutions(name: "US Bank", code: "us", image: "https://cdn.synapsepay.com/bank_logos_v3p1/us_v.png"))
        topBanks.append(clsInstitutions(name: "TD Bank", code: "td", image: "https://cdn.synapsepay.com/bank_logos_v3p1/TD_v.png"))
        topBanks.append(clsInstitutions(name: "Capital One", code: "capone", image: "https://cdn.synapsepay.com/bank_logos_v3p1/CapitalOne360_v.png"))
        topBanks.append(clsInstitutions(name: "HSBC USA", code: "hsbc", image: ""))
        self.collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnVerifyContinue_pressed(_ sender: UIButton) {
        if !self.vwBankLogin.isHidden {
            self.addAccountPresenter = AccountAggregatePresenter(delegate: self)
            self.addAccountPresenter.sendAccountAggregateRequest(bank: "fake", id: txtUserId.text!, password: txtPassword.text!)
        }else{
            self.addAccountPresenter.sendMFARequest(token: aggregateData.mfa!.accessToken, answer: txtSecurityAnswer.text!)
        }
//        closeVerification()
//        self.navigationController?.popViewController(animated: true)
//        self.getControllerWithIdentifier(<#T##identifier: String##String#>)
    }
    
    @IBAction func btnBackVerify_pressed(_ sender: UIButton) {
        closeVerification()
    }
    
    @IBAction func btnCloseVerify_pressed(_ sender: UIButton) {
        closeVerification()
    }
    
    @IBAction func btnConfirm_pressed(_ sender: UIButton) {
        self.showAlert(title: "", message: "Acount Linked Successfully!")
        closeVerification()
    }
    
    func openVerification(){
        self.btnVerifyContinue.isEnabled = false
        self.vwBankLogin.isHidden = false
        self.vwSecurityQuestion.isHidden = true
        self.vwVerifyAccount.isHidden = false
        self.vwAccountSelection.isHidden = true
        self.txtSecurityAnswer.text = ""
        self.txtUserId.text = ""
        self.txtPassword.text = ""
        lblVerificationTitle.text = "Please enter your online banking username and password"
        if let imgUrl = selectedBank.logo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string:imgUrl){
                self.imgBankLogo.setImageWith(url)
            }
        }

    }
    
    func closeVerification(){
        self.vwVerifyAccount.isHidden = true
    }
    
    @IBAction func txtSearch_changed(_ sender: UITextField) {
        if let str = sender.text?.trimmingCharacters(in: .whitespaces), str.count > 0 {
            banks = []
            for bank in institutionData.values{
                if bank.bankName.lowercased().contains(str){
                    banks.append(bank)
                }
            }
        }else{
            banks = institutionData.values
        }
        self.tableView.reloadData()
    }
}

extension AddBankController:AccountAggregateDelegate{
    func didFetchAccountAggregate(data: AccountAggregate) {
        aggregateData = data.data
        if data.data.statusCode == 202{
//            if data.message.count > 0{
//                self.showAlert(title: "", message: data.message)
//            }
            self.vwBankLogin.isHidden = true
            self.vwSecurityQuestion.isHidden = false
            self.lblVerificationTitle.text = data.data.mfa?.message
            self.btnVerifyContinue.isEnabled = false
            self.txtSecurityAnswer.text = ""
        }else if data.data.statusCode == 200{
            if data.data.nodes.count > 1{
                selectedNode = nil
                btnConfirm.isEnabled = false
                self.constTableAccountSelect.constant = CGFloat(aggregateData.nodes.count) * self.tableView.rowHeight
                self.vwSecurityQuestion.isHidden = true
                self.vwAccountSelection.isHidden = false
                self.tableAccountSelect.reloadData()
            }else{
                self.showAlert(title: "", message: "Acount Linked Successfully!")
                closeVerification()
            }
        }
    }
}

extension AddBankController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    /// Will configure collection View
    func configureCollectionView(){
        self.collectionView.dataSource=self
        self.collectionView.delegate=self
        collectionView.register(UINib.init(nibName: "BankCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BankCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topBanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankCollectionCell", for: indexPath) as! BankCollectionCell
        let bank = topBanks[indexPath.row]
        cell.lblName.text = bank.bankName
        if let imgUrl = bank.logo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string:imgUrl){
                cell.imgPreview.setImageWith(url)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 3;
        let height = collectionView.frame.height/2
        return CGSize(width:widthPerItem, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        openVerification()
    }
}

extension AddBankController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 76;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerTableViewCell(tableViewCell: BankCell.self)
        self.tableAccountSelect.registerTableViewCell(tableViewCell: BankCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return banks.count
        } else{
            if aggregateData != nil{
                return aggregateData.nodes.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell") as! BankCell
        
        if tableView == tableAccountSelect {
            cell.bindData(data: aggregateData.nodes[indexPath.row].info)
            cell.imgCheckbox.isHidden = selectedNode == nil || selectedNode.account_num != aggregateData.nodes[indexPath.row].info.account_num
        }else{
            //        cell.bindData(option: optionArray[indexPath.row])
            cell.bindData(data: banks[indexPath.row])
            cell.imgCheckbox.isHidden = true
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.LightGray251
        cell.selectedBackgroundView = bgColorView
        
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableAccountSelect {
            btnConfirm.isEnabled = true
            selectedNode = aggregateData.nodes[indexPath.row].info
            self.tableAccountSelect.reloadData()
        }else{
            selectedBank = banks[indexPath.row]
            openVerification()
        }
    }
}

extension AddBankController:InstitutionsDelegate{
    func didFetchInstitutions(data: InstitutionsData) {
        institutionData = data
        self.banks = data.values
    }
}

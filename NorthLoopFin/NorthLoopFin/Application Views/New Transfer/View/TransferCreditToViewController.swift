//
//  TransferCreditToViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferCreditToViewController: BaseViewController {

    @IBOutlet weak var firstBankView: UIView!
    @IBOutlet weak var addBankAccountView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblDebitFromDetail: LabelWithLetterSpace!
    @IBOutlet weak var btnNext: RippleButton!
    var selectedNode:ACHNode!
    var footer:vwAddAccountFooter?
    var deletePresenter:DeleteACHPresenter!
    var presenter:FetchACHPresenter!
    var achNodeArray:[ACHNode] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter = FetchACHPresenter.init(delegate: self)
        self.presenter.sendFetchACRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        
        btnNext.isEnabled = false
        
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        self.lblDebitFromDetail.text = "$"+String(currentUser!.amount) + " available for transfer"

        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNext_pressed(_ sender: UIButton) {
        let vc = self.getControllerWithIdentifier("TransferDetailViewController") as! TransferDetailViewController
        vc.node = selectedNode
        vc.amount = footer!.amountTextField.text!
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension TransferCreditToViewController:FetchACHDelegates{
    func didSentFetchACH(data: [ACHNode]) {
        achNodeArray = data
    }
}

extension TransferCreditToViewController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 76;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerTableViewCell(tableViewCell: BankCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achNodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell") as! BankCell
        cell.bindData(data: achNodeArray[indexPath.row])
        cell.imgCheckbox.isHidden = selectedNode == nil || selectedNode.account_num != achNodeArray[indexPath.row].account_num
        cell.backgroundColor = cell.imgCheckbox.isHidden ? UIColor.clear : Colors.LightGray251
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete_pressed(button:)), for: .touchUpInside)
        cell.btnDelete.isHidden = false

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if footer == nil{
            footer = vwAddAccountFooter.instantiateFromNib()
            footer!.btnAddBank.addTarget(self, action: #selector(addBank), for: .touchUpInside)
            footer!.lblAddBank.text = "Add a bank account"
            footer!.amountTextField.isHidden = false// achNodeArray.count == 0
            footer!.amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        }
        return footer
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return achNodeArray.count == 0 ? 56 : 156
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNode = achNodeArray[indexPath.row]
        self.tableView.reloadData()
        btnNext.isEnabled = footer!.amountTextField.text!.count > 0
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        btnNext.isEnabled = footer!.amountTextField.text!.count > 0 && selectedNode != nil
    }
    
    @objc func btnDelete_pressed(button: UIButton){
        self.deletePresenter = DeleteACHPresenter.init(delegate: self)
        self.deletePresenter.deleteACRequest(nodeid: achNodeArray[button.tag].node_id)
    }
    
    @objc func addBank(){
        self.navigationController?.pushViewController(self.getControllerWithIdentifier("TransferViewController"), animated: true)
    }
}

extension TransferCreditToViewController:DeleteACHDelegates{
    func didDeleteACH(data:DeletedACHNode){
        var index = -1
        for node in achNodeArray {
            index += 1
            if node.node_id == data.nodeID{
                achNodeArray.remove(at: index)
                break
            }
        }
        self.tableView.reloadData()
    }
}

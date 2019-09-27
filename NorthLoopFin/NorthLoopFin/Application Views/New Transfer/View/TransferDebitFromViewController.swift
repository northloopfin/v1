//
//  TransferDebitFromViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferDebitFromViewController: BaseViewController {

    @IBOutlet weak var firstBankView: UIView!
    @IBOutlet weak var secondBankView: UIView!
    @IBOutlet weak var addBankAccountView: UIView!
    @IBOutlet weak var addAmountTextField: UITextField!
    @IBOutlet weak var firstBankHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondBankHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHeader: LabelWithLetterSpace!
    
    @IBOutlet weak var nextButton: RippleButton!

    var selectedNode:ACHNode!
    var footer:vwAddAccountFooter?
    var presenter:FetchACHPresenter!
    var achNodeArray:[ACHNode] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextButton.isEnabled = false
        self.presenter = FetchACHPresenter.init(delegate: self)
        self.presenter.sendFetchACRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        configureTableView()
        self.lblHeader.text = "Add Funds"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNext_pressed(_ sender: UIButton) {
        let vc = self.getControllerWithIdentifier("TransferDetailViewController") as! TransferDetailViewController
        vc.node = selectedNode
        vc.amount = footer!.amountTextField.text!
        vc.addFund = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension TransferDebitFromViewController:FetchACHDelegates{
    func didSentFetchACH(data: [ACHNode]) {
        achNodeArray = []
        for node in data {
            if node.allowed == "CREDIT-AND-DEBIT"{
                achNodeArray.append(node)
            }
        }
        self.tableView.reloadData()
    }
}

extension TransferDebitFromViewController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 91;
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
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if footer == nil{
            footer = vwAddAccountFooter.instantiateFromNib()
            footer!.btnAddBank.addTarget(self, action: #selector(addBank), for: .touchUpInside)
            footer!.amountTextField.isHidden = false// achNodeArray.count == 0
            footer!.amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        }
        if achNodeArray.count == 0 {
            footer!.lblAddBank.text  = "Add a bank account "
        }else{
            footer!.lblAddBank.text  =  "Add another bank account "
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
        nextButton.isEnabled = footer!.amountTextField.text!.count > 0
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        nextButton.setTitle("ADD $" + footer!.amountTextField.text!, for: .normal)
        nextButton.isEnabled = footer!.amountTextField.text!.count > 0 && selectedNode != nil
    }

    @objc func addBank(){
        self.tableView.reloadData(); self.navigationController?.pushViewController(self.getControllerWithIdentifier("AddBankController"), animated: true)
    }
}

public extension UIView {
    
    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
    
}

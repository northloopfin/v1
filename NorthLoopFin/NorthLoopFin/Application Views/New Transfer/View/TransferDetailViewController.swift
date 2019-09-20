//
//  TransferDetailViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 20/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferDetailViewController: BaseViewController {

    @IBOutlet weak var mainTitleLabel: LabelWithLetterSpace!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var transferAmountButton: RippleButton!
    
    var accountInfoPresenter : AccountInfoPresenter!
    var presenter:ACHTransactionPresenter!

    var data:[TransferDetailCellModel]=[]
    var amount:String = ""
    var node:ACHNode!
    
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightNavigationBar()
        self.prepareView()
        self.tableView.reloadData()
        
        presenter = ACHTransactionPresenter.init(delegate: self)
        accountInfoPresenter = AccountInfoPresenter.init(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    func prepareView()
    {
        configureTableView()
        let row1 = TransferDetailCellModel.init(AppConstants.TransferDetail.FROM.rawValue, detailValue: "North Loop Bank")
        let row2 = TransferDetailCellModel.init(AppConstants.TransferDetail.TO.rawValue, detailValue: node.nickname)
        let row3 = TransferDetailCellModel.init(AppConstants.TransferDetail.TIME.rawValue, detailValue: "1 - 2 business days")
        let row4 = TransferDetailCellModel.init(AppConstants.TransferDetail.FEES.rawValue, detailValue: "$ 0.00")
        let row5 = TransferDetailCellModel.init(AppConstants.TransferDetail.TOTALAMOUNT.rawValue, detailValue: "$ " + amount)
        data.append(row1)
        data.append(row2)
        data.append(row3)
        data.append(row4)
        data.append(row5)
        
        transferAmountButton.setTitle("TRANSFER $" + amount, for: .normal)
    }

    @IBAction func transferAmountButtonAction(_ sender: Any) {
        accountInfoPresenter.getAccountInfo()
    }
}

extension TransferDetailViewController:HomeDelegate{
    func didFetchedTransactionList(data: [TransactionListModel]) {
    }
    func didFetchedError(error:ErrorModel){
    }
    func didFetchedAccountInfo(data:Account){
        if (data.data.info.balance.amount.isLess(than: Double(self.amount) ?? 0.0)){
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.INSUFFICIENT_BALANCE.rawValue)
        }else{
            self.presenter.sendACHTransactionRequest(amount: amount, nodeID: (node.nodeID))
        }
    }
}

extension TransferDetailViewController:ACHTransactionDelegates{
    func didSentFetchACH() {
        self.moveToSucessScreen()
    }
    
    func moveToSucessScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TransferSuceessViewController") as! TransferSuceessViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}


extension TransferDetailViewController:UITableViewDelegate,UITableViewDataSource
{
    func configureTableView(){
        self.tableView.rowHeight = 92;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.tableFooterView = self.bottomView
        self.tableView.registerTableViewCell(tableViewCell:TransferDetailTableViewCell.self)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransferDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TransferDetailTableViewCell") as! TransferDetailTableViewCell
        cell.configureCell(data: data[indexPath.row])
        return cell
    }
}


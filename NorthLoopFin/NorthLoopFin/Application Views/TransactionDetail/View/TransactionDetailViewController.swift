//
//  TransactionDetailViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class TransactionDetailViewController: BaseViewController {
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var beneficiaryNameLbl: UILabel!
    @IBOutlet weak var transactionPurposeLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var amtLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    var detailModel:Transaction!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIForRecievedData()
        self.configureTable()
        self.historyTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func updateUIForRecievedData(){
        self.beneficiaryNameLbl.text = self.detailModel.transactionPrintout.beneficiaryname
        self.amtLbl.text = String(self.detailModel.amount)
    }
}

extension TransactionDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func configureTable(){
        self.historyTableView.rowHeight = 44;
        self.historyTableView.delegate=self
        self.historyTableView.dataSource=self
        self.historyTableView.registerTableViewCell(tableViewCell: TransactionDetailHistoryCell.self)
        self.historyTableView.registerTableViewHeaderFooterView(tableViewHeaderFooter: TransactionDetailHistoryTableHeader.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionDetailHistoryCell = tableView.dequeueReusableCell(withIdentifier: "TransactionDetailHistoryCell") as! TransactionDetailHistoryCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TransactionDetailHistoryTableHeader") as! TransactionDetailHistoryTableHeader
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 49
    }
}

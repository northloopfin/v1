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
    var data:[TransferDetailCellModel]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func prepareView()
    {
        let row1 = TransferDetailCellModel.init(AppConstants.TransferDetail.FROM.rawValue, detailValue: "Bank of America - 6814")
        let row2 = TransferDetailCellModel.init(AppConstants.TransferDetail.TO.rawValue, detailValue: "North Loop Bank")
        let row3 = TransferDetailCellModel.init(AppConstants.TransferDetail.TIME.rawValue, detailValue: "1 - 2 business days")
        let row4 = TransferDetailCellModel.init(AppConstants.TransferDetail.FEES.rawValue, detailValue: "$ 0.00")
        let row5 = TransferDetailCellModel.init(AppConstants.TransferDetail.TOTALAMOUNT.rawValue, detailValue: "$ 50.00")
        data.append(row1)
        data.append(row2)
        data.append(row3)
        data.append(row4)
        data.append(row5)
    }

    @IBAction func transferAmountButtonAction(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TransferDetailViewController:UITableViewDelegate,UITableViewDataSource
{
    func configureTableView(){
        self.tableView.rowHeight = 92;
        self.tableView.delegate=self
        self.tableView.dataSource=self
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

//
//  HomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var ledgersTableView: UITableView!
    var homePresenter: HomePresenter!
    @IBOutlet weak var contentView: GradientView!
    var transactionDataSource: [TransactionListModel] = [] {
        didSet {
            self.ledgersTableView.reloadData()
        }
    }
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIWithData()
        self.configureTable()
        self.ledgersTableView.reloadData()
        homePresenter = HomePresenter.init(delegate: self)
        self.getTransactionList()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.makeTransparent()
    }
    
    func updateUIWithData(){
        let shadowOffst = CGSize.init(width: 0, height: 9)
        let shadowOpacity = 0.21
        let shadowRadius = 72
        //let shadowColor = UIColor.blue
        let shadowColor = Colors.Zorba161149133
        self.contentView.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    
    /// This method is used to get list of Tranactions from api
    func getTransactionList(){
        homePresenter.sendTransactionListRequest()
    }
    ///Move to detail screen
    func moveToDetailScreen(detailModel:Transaction){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetailViewController") as! TransactionDetailViewController
       transactionDetailController.detailModel = detailModel
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    //Configure table view delgates and data source
    func configureTable(){
        self.ledgersTableView.rowHeight = 44;
        self.ledgersTableView.delegate=self
        self.ledgersTableView.dataSource=self
        self.ledgersTableView.registerTableViewCell(tableViewCell: HomeTableCell.self)
        self.ledgersTableView.registerTableViewHeaderFooterView(tableViewHeaderFooter: HomeTableSectionCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let transactions = transactionDataSource[section]
        return transactions.rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        let rowData = transactionDataSource[indexPath.section].rowData[indexPath.row]
        cell.selectionStyle = .none
        cell.bindData(data: rowData)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.transactionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableSectionCell") as! HomeTableSectionCell
        headerView.bindData(data: transactionDataSource[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToDetailScreen(detailModel: transactionDataSource[indexPath.section].rowData[indexPath.row])
    }
}

extension HomeViewController:HomeDelegate{
    //MARK: HomeDelegate
    func didFetchedTransactionList(data: [TransactionListModel]) {
        self.transactionDataSource = data
    }
}

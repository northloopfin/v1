//
//  ViewAccountsViewController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ViewAccountsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    public var achNodeArray:[ACHNode] = []
    var presenter:DeleteACHPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Linked Accounts")
        self.presenter = DeleteACHPresenter.init(delegate: self)

        // Do any additional setup after loading the view.
    }
}

extension ViewAccountsViewController:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.tableView.rowHeight = 300;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableViewCell(tableViewCell: ACHAccountCell.self)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achNodeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACHAccountCell") as! ACHAccountCell
        
        let rowData = self.achNodeArray[indexPath.row]
        cell.bindData(data: rowData, delegate: self)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedAtm = self.dataSource[indexPath.row+1]
    }
}

extension ViewAccountsViewController:ACHCellDelegate{
    func removeClicked(data:ACHNode){
        presenter.deleteACRequest(nodeid: data.nodeID)
    }
}


extension ViewAccountsViewController:DeleteACHDelegates{
    func didDeleteACH(data:DeletedACHNode){
        var index = -1
        for node in achNodeArray {
            index += 1
            if node.nodeID == data.nodeID{
                achNodeArray.remove(at: index)
                break
            }
        }
        self.tableView.reloadData()
    }
}

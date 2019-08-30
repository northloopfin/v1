//
//  CurrencyProtectController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 08/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CurrencyProtectController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var fetchPresenter: FetchWireListPresenter?

    var wireList: [WireTransaction] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.configureTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getWireList()
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
    }
    
    func getWireList(){
        self.fetchPresenter = FetchWireListPresenter(delegate: self)
        self.fetchPresenter?.sendFetchRequest()
    }
}

extension CurrencyProtectController:UITableViewDelegate,UITableViewDataSource{
    
    func configureTable(){
        self.tableView.rowHeight = 61;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableViewCell(tableViewCell: CurrencyProtectCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wireList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencyProtectCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyProtectCell") as! CurrencyProtectCell
        cell.selectionStyle = .none
        cell.bindData(data: wireList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = wireList[indexPath.row]
        let vc = getControllerWithIdentifier("WireRateController") as! WireRateController
        vc.transactionID = data.transaction_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CurrencyProtectController:FetchWireListDelegates{
    func didFetcWireList(data: [WireTransaction]) {
        wireList = data
    }
}

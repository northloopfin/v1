//
//  CommonTable.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CommonTable: UIView {
    @IBOutlet weak var optionsTableView: UITableView!
    var dataSource:[String]=[]

    @IBOutlet var containerView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit(){
        
    }
}

extension CommonTable:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.optionsTableView.rowHeight = 62;
        self.optionsTableView.delegate=self
        self.optionsTableView.dataSource=self
        self.optionsTableView.registerTableViewCell(tableViewCell: SideMenuTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SideMenuTableCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableCell") as! SideMenuTableCell
        cell.bindData(data: dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 62.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

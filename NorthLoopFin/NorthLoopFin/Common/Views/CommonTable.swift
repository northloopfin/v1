//
//  CommonTable.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CommonTable: UIView {
    @IBOutlet weak var optionsTableView: SelfSizedTableView!
    var dataSource:[String]=[]
    @IBOutlet var containerView: UIView!
    var delegate:CommonTableDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    /// Method to initialize view
    func commonInit(){
        Bundle.main.loadNibNamed("CommonTable", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame=self.bounds
        containerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.configureTableView()
        self.optionsTableView.reloadData()
    }
}

extension CommonTable:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.optionsTableView.rowHeight = 70;
        self.optionsTableView.delegate=self
        self.optionsTableView.dataSource=self
        self.optionsTableView.registerTableViewCell(tableViewCell: CommonTableCell.self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CommonTableCell = tableView.dequeueReusableCell(withIdentifier: "CommonTableCell") as! CommonTableCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.Cameo213186154
        cell.selectedBackgroundView = backgroundView
        cell.bindData(data: dataSource[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectOption(optionVal: indexPath.row)
    }
}

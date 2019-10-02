//
//  AnalysisCategoryDetailVC.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 01/10/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AnalysisCategoryDetailVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCategoryTitle: LabelWithLetterSpace!
    
    var period:AnalysisPeriod!
    var category:UserAnalysisCategory!
    var presenter:AnalysisPresenter!
    var expenses:[AnalysisCategoryData] = []{
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.setupRightNavigationBar()
        self.lblCategoryTitle.text = category.categoryTitle
        presenter = AnalysisPresenter(delegate: self)
        presenter.fetchCategoryAnalysis(category: category.categoryForTrans, month: period.month, year:period.year)
    }
}

extension AnalysisCategoryDetailVC:AnalysisPresenterDelegate {
    func didFetchAnalysisCategories(_ categories: [UserAnalysisCategory]) {
    }
    
    func didFetchAnalysisTotalSpent(_ totalSpent: AnalysisTotalSpent) {
    }
    
    func didFetchAnalysisCategory(_ values: AnalysisCategory) {
        expenses = values.data
    }
}

extension AnalysisCategoryDetailVC:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 63;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerTableViewCell(tableViewCell: AnalysisCategoryDetailCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisCategoryDetailCell") as! AnalysisCategoryDetailCell
        cell.bindData(data: expenses[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.rowHeight
    }
}

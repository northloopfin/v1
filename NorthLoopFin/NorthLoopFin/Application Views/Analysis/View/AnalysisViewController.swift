//
//  AnalysisViewController.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit
import MFSideMenu

class AnalysisViewController: BaseViewController {
    @IBOutlet weak var labelCurrentBalance: UILabel!
    @IBOutlet weak var labelSpent: UILabel!
    @IBOutlet weak var labelTotalSpent: UILabel!
    @IBOutlet weak var labelNoOption: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewDate: UITableView!
    @IBOutlet weak var constraintBtnDateWidth: NSLayoutConstraint!
    @IBOutlet weak var viewDropdown: UIView!
    var presenter: AnalysisPresenter!
    var presenterDate = AnalysisDatePresenter()
    var isDateShown:Bool = false
    var selectedDateIndexPath:IndexPath? = nil
    
    var analysisOptions:[UserAnalysisCategory] = [] {
        didSet {
            if analysisOptions.count == 0 {
                labelNoOption.isHidden = false
                tableView.isHidden = true
            } else {
                labelNoOption.isHidden = true
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
    }
    
    var dateOptions:[AnalysisPeriod] = [] {
        didSet {
            if dateOptions.count == 0 {
                btnDate.isHidden = true
            } else {
                dateOptions = dateOptions.reversed()
                btnDate.isHidden = false
                let text = dateOptions.first?.title ?? ""
                let fontAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Calibri", size: 14)]
                let size = text.size(withAttributes: fontAttributes)
                btnDate.setTitle(text, for: .normal)
                constraintBtnDateWidth.constant = size.width + 40
                self.tableViewDate.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTable()
        self.setupRightNavigationBar()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidePeriodPicker))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        getAnalysisDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.makeTransparent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
 

    func setupUI() {
        btnDate.layer.borderWidth = 1
        btnDate.layer.borderColor = UIColor(red: 176/255, green: 73/255, blue: 149/255, alpha: 1.0).cgColor
        
        viewDropdown.alpha = 0
        viewDropdown.layer.shadowColor = UIColor(red: 177/255, green: 76/255, blue: 150/255, alpha: 1.0).cgColor
        viewDropdown.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        viewDropdown.layer.shadowOpacity = 0.15
        viewDropdown.layer.shadowRadius = 10.0
        
        labelNoOption.isHidden = false
        tableView.isHidden = true
        
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
//        let formatter = NumberFormatter()
//        formatter.locale = Locale.current
//        formatter.numberStyle = .currency
        labelCurrentBalance.text = "$" + String(currentUser?.amount ?? 0)
    }
    
    override func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.openMenu)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    //Method to go back to previous screen
    @objc func openMenu(){
        self.menuContainerViewController.setMenuState(MFSideMenuStateLeftMenuOpen, completion: {})
    }

    
    @IBAction func onDate(_ sender: Any) {
        if isDateShown {
            hidePeriodPicker()
        } else {
            if let indexPath = self.selectedDateIndexPath {
                self.tableViewDate.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
            UIView.animate(withDuration: 0.2) {
                self.viewDropdown.alpha = 1
            }
            isDateShown = true
            btnDate.isSelected = true
        }
    }
    
    @objc func hidePeriodPicker() {
        isDateShown = false
        btnDate.isSelected = false
        UIView.animate(withDuration: 0.2) {
            self.viewDropdown.alpha = 0
        }
    }
    
    //Method to go back to previous screen
    @objc func popController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func getAnalysisDetail() {
        dateOptions = presenterDate.getDateListForAnalysis()
        self.presenter = AnalysisPresenter.init(delegate: self)
        if let currentDate = dateOptions.first {
            self.presenter.fetchAnalysisCategories(month: currentDate.month, year:currentDate.year)
            selectedDateIndexPath = IndexPath.init(row: 0, section: 0)
        } else {
            selectCurrentDate()
        }
    }
    
    func selectCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let text = formatter.string(from: Date())
        btnDate.setTitle(text, for:.normal)
        let fontAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Calibri", size: 14)]
        let size = text.size(withAttributes: fontAttributes)
        constraintBtnDateWidth.constant = size.width + 40
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
        
        formatter.dateFormat = "MM"
        let currentMonth = formatter.string(from: Date())
        formatter.dateFormat = "yyyy"
        let currentYear = formatter.string(from: Date())
        self.presenter.fetchAnalysisCategories(month: currentMonth, year:currentYear)
    }
}
    
extension AnalysisViewController: UITableViewDelegate,UITableViewDataSource, CalendarTableViewCellDelegate {
    func configureTable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"AnalysisCategoryTableViewCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "AnalysisCategoryTableViewCell")
        tableView.register(UINib(nibName:"AnalysisCategoryTableHeader", bundle: Bundle(for: type(of: self))), forHeaderFooterViewReuseIdentifier: "AnalysisCategoryTableHeader")
        tableViewDate.register(UINib(nibName:"CalendarTableViewCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CalendarTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tableViewDate ? dateOptions.count : analysisOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == tableViewDate) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
            cell.dateTitle = dateOptions[indexPath.row].title
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisCategoryTableViewCell", for: indexPath) as! AnalysisCategoryTableViewCell
        cell.category = analysisOptions[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableViewDate {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AnalysisCategoryTableHeader") as! AnalysisCategoryTableHeader
        headerView.categories = analysisOptions
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == tableViewDate ? 0 : 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.getControllerWithIdentifier("AnalysisCategoryDetailVC") as! AnalysisCategoryDetailVC
        vc.period = dateOptions[selectedDateIndexPath!.row]
        vc.category = analysisOptions[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onPeriod(_ cell:UITableViewCell) {
        hidePeriodPicker()
        if let indexPath = tableViewDate.indexPath(for: cell) {
            if dateOptions.count > indexPath.row {
                selectedDateIndexPath = indexPath
                let text = dateOptions[indexPath.row].title
                btnDate.setTitle(text, for:.normal)
                let fontAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Calibri", size: 14)]
                let size = text.size(withAttributes: fontAttributes)
                constraintBtnDateWidth.constant = size.width + 40
                UIView.animate(withDuration: 0.1) {
                    self.view.layoutIfNeeded()
                }
                self.presenter.fetchAnalysisCategories(month: dateOptions[indexPath.row].month, year:dateOptions[indexPath.row].year)
            } else {
                selectCurrentDate()
            }
        } else {
            selectCurrentDate()
        }
    }
}

extension AnalysisViewController:AnalysisPresenterDelegate {
    func didFetchAnalysisCategories(_ categories:[UserAnalysisCategory]) {
        analysisOptions = categories
//        var sum = 0.0
//        for option in analysisOptions {
//            sum += option.sumAmount
//        }
//        let formatter = NumberFormatter()
//        formatter.locale = Locale.current
//        formatter.numberStyle = .currency
//        let sumCurrency = formatter.string(from: NSNumber(value:sum)) ?? "0.00"
//        labelTotalSpent.text = "Total " + sumCurrency + " spent"
        if analysisOptions.count > 0 {
            self.presenter.fetchAnalysisTotalSpent(month: dateOptions[selectedDateIndexPath!.row].month, year:dateOptions[selectedDateIndexPath!.row].year)
        }else{
            labelSpent.text = "$0";//"Total $0 spent"
        }
    }
    
    func didFetchAnalysisTotalSpent(_ totalSpent: AnalysisTotalSpent) {
        labelTotalSpent.text = "" //"Total " + sumCurrency + " spent"
        labelSpent.text = "$" + String(totalSpent.sumAmount)
    }
    
    func didFetchAnalysisCategory(_ values: AnalysisCategory) {
        
    }
}



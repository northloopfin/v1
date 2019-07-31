//
//  AnalysisViewController.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {
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
    var isDateShown:Bool = false
    
    var analysisOptions:[AnalysisCategory] = [] {
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
    
    var dateOptions:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightNavigationBar()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        getAnalysisDetail()
    }
    
    //Methode initialises the rightbutton for navigation
    //override
    func setupRightNavigationBar() {
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "btn_back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.popController)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    func setupUI() {
        btnDate.layer.borderWidth = 1
        btnDate.layer.borderColor = UIColor(red: 176/255, green: 73/255, blue: 149/255, alpha: 1.0).cgColor
        
        viewDropdown.alpha = 0
        viewDropdown.layer.shadowColor = UIColor(red: 177/255, green: 76/255, blue: 150/255, alpha: 1.0).cgColor
        viewDropdown.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        viewDropdown.layer.shadowOpacity = 0.15
        viewDropdown.layer.shadowRadius = 10.0
        
        let text = "June 2019"
        let fontAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Calibri", size: 14)]
        let size = text.size(withAttributes: fontAttributes)
        constraintBtnDateWidth.constant = size.width + 40
    }
    
    @IBAction func onDate(_ sender: Any) {
        if isDateShown {
            UIView.animate(withDuration: 0.2) {
                self.viewDropdown.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.viewDropdown.alpha = 1
                self.tableViewDate.reloadData()
            }
        }
        btnDate.isSelected = !btnDate.isSelected
        isDateShown = !isDateShown
    }
    
    //Method to go back to previous screen
    @objc func popController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func getAnalysisDetail() {
//        presenter.sendAnalysisDetailRequest()
        analysisOptions = [
            AnalysisCategory(summa: -200, type: .entertainment),
            AnalysisCategory(summa: -20, type: .food),
            AnalysisCategory(summa: -30, type: .shopping),
            AnalysisCategory(summa: -20, type: .miscellaneous)
        ]
        dateOptions = [
            "January 2019",
            "February 2019",
            "March 2019",
            "April 2019",
            "May 2019",
            "June 2019",
            "July 2019",
            "August 2019",
            "September 2019",
            "October 2019",
            "November 2019",
            "December 2019"
        ]
    }
}
    
extension AnalysisViewController: UITableViewDelegate,UITableViewDataSource, CalendarTableViewCellDelegate {
    func configureTable(){
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
            cell.dateTitle = dateOptions[indexPath.row]
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisCategoryTableViewCell", for: indexPath) as! AnalysisCategoryTableViewCell
        cell.category = analysisOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableViewDate {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AnalysisCategoryTableHeader") as! AnalysisCategoryTableHeader
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == tableViewDate ? 0 : 200
    }
    
    func onDate(_ title:String?) {
        let text = title ?? "June 2019"
        btnDate.setTitle(text, for:.normal)
        let fontAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Calibri", size: 14)]
        let size = text.size(withAttributes: fontAttributes)
        constraintBtnDateWidth.constant = size.width + 40
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }

}

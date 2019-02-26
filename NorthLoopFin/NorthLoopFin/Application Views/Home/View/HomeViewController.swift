//
//  HomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu

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
        self.setupRightNavigationBar()
        // enable the menu slide animation
        
        // control the exaggeration of the menu slide animation
        //[menuContainerViewController setMenuSlideAnimationFactor:3.0f];
        self.menuContainerViewController.menuSlideAnimationEnabled = true
        self.menuContainerViewController.menuSlideAnimationFactor = 10.0
        self.menuContainerViewController.shadow.enabled=false
        self.ledgersTableView.reloadData()
        homePresenter = HomePresenter.init(delegate: self)
        self.getTransactionList()
        self.loadHardcodedData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.makeTransparent()
    }
    
    func loadHardcodedData(){
        let dummy1:Dummy = Dummy.init(name: "Dominos", code: "$24.49", image: UIImage.init(named: "Dummy1")!)
        let dummy2:Dummy = Dummy.init(name: "Starbucks", code: "$4.98", image: UIImage.init(named: "Dummy2")!)
        let dummy3:Dummy = Dummy.init(name: "NetFlix", code: "$15.99", image: UIImage.init(named: "Dummy3")!)
        let dummy4:Dummy = Dummy.init(name: "H&M", code: "$38.98", image: UIImage.init(named: "Dummy4")!)
        let arr = [dummy1,dummy2,dummy3,dummy4]
        let data = TransactionListModel.init(sectionTitle: "September 8th,2018", rowData: arr)
        self.transactionDataSource.append(data)
    }
    
    //Methode initialises the rightbutton for navigation
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
        //homePresenter.sendTransactionListRequest()
    }
    ///Move to detail screen
    func moveToDetailScreen(detailModel:Dummy){
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
        
        return 29
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

extension HomeViewController:SideMenuDelegate{
    func closeMenu() {
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
    }
    
    func moveToScreen(screen: AppConstants.SideMenuOptions) {
        switch screen {
        case .MYCARD:
            self.navigateToMyCard()
        case .HELP:
            self.navigateToHelp()
        case .TRANSFER:
            self.navigateToTransfer()
        case .MYACCOUNT:
            self.navigateToMyAccount()
        case .GOALS:
            self.navigateToGoals()
        case .EXPENSES:
            self.navigateToExpenses()
        case .SETTINGS:
            self.navigateToSettings()
        default:
            break
        }
    }
    
    func navigateToMyCard(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "MyCardViewController") as! MyCardViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToSettings(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToTransfer(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "TransferViewController") as! TransferViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToMyAccount(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "MyAccountViewController") as! MyAccountViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToGoals(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "GoalsViewController") as! GoalsViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToExpenses(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ExpensesViewController") as! ExpensesViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func navigateToHelp(){
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
}

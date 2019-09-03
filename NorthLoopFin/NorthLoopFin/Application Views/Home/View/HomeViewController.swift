//
//  HomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import MFSideMenu
import AlertHelperKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var ledgersTableView: UITableView!
    @IBOutlet weak var GreetingLbl: LabelWithLetterSpace!
    @IBOutlet weak var AccBalanceLbl: LabelWithLetterSpace!
    
    var transactionListPresenter: TransactionListPresenter!
    var accountInfoPresenter : AccountInfoPresenter!
    var shareAccountDetailsPresenter : ShareAccountDetailsPresenter!
    var cardAuthPresenter: CardAuthPresenter!
    var cardAuthData:CardAuthData?
    var currentDateForLog: Date!

    @IBOutlet weak var vwEmpty: UIView!
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
        transactionListPresenter = TransactionListPresenter.init(delegate: self)
        accountInfoPresenter = AccountInfoPresenter.init(delegate: self)
        shareAccountDetailsPresenter = ShareAccountDetailsPresenter.init(delegate: self)
        cardAuthPresenter = CardAuthPresenter.init(delegate: self)
        self.getAccountInfo()
        self.hideTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.makeTransparent()
        currentDateForLog = Date()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logEventsHelper.logEventWithName(name: "PageView", andProperties: ["Event": "Homepage", "Duration":"\(Date() - currentDateForLog)"])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.contentView.cornerRadius = self.contentView.frame.size.height/2
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
    
    //Check for first time land on Home. If it's first time then show pop up
    func checkForFirstTimeLandOnHome(){
        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForFirstTimeLandOnHome){
            //key exist , now check its value
            let isFirstTimeLandOnHome:Bool = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForFirstTimeLandOnHome) as! Bool
            if !isFirstTimeLandOnHome{
                //if its true , then user must have landed on home and set this key to true
                //but if its false then, user landed first time on home and need to set this key to true
                // set this key to true
                UserDefaults.saveToUserDefault(true as AnyObject, key: AppConstants.UserDefaultKeyForFirstTimeLandOnHome)
                //show popup here
                self.showPopUpForFirstTimeLandOnHome()
            }
        }else{
            //key not found .. so set this key to true then
            UserDefaults.saveToUserDefault(true as AnyObject, key: AppConstants.UserDefaultKeyForFirstTimeLandOnHome)
            //show popup here
            self.showPopUpForFirstTimeLandOnHome()
        }
    }
    
    //Show pop up to user , when landed first time on home
    func showPopUpForFirstTimeLandOnHome(){
        let params = Parameters(
            title: "",
            message: AppConstants.ErrorMessages.FIRST_TIME_LAND_HOME_MESSAGE.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Done"],
            inputFields: [InputField(placeholder: "Enter Email", secure: false)]
        )
        let alert = AlertHelperKit()
        alert.showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                
                if let textFields = alert.textFields {
                    // username
                    let emailEntered: UITextField = textFields[0] as! UITextField
               //check for valid email
                    
                    if (!(emailEntered.text?.isEmpty)! && Validations.isValidEmail(email: (emailEntered.text)!)){
                        // valid
                        self.shareAccountDetailsPresenter.sendShareAccountDetailsRequest(email: emailEntered.text!)
                    }else{
                        // show error
                        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
                    }
                }
            }
        }
    }
    

    func updateUIWithData(){
        /*
        let shadowOffst = CGSize.init(width: 0, height: 9)
        let shadowOpacity = 0.21
        let shadowRadius = 72
        //let shadowColor = UIColor.blue
        let shadowColor = Colors.PurpleColor17673149
        self.contentView.layer.addShadowAndRoundedCorners(roundedCorner: self.contentView.frame.size.height/2, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)*/
    }
    
    /// This method is used to get list of Tranactions from api
    func getTransactionList(){
        transactionListPresenter.sendTransactionListRequest()
    }
    
    /// This Methode will get account info that will show current account balance
    func getAccountInfo(){
        accountInfoPresenter.getAccountInfo()
    }
    
    //Getting card info for faster loading
    func getCardInfo(){
        cardAuthPresenter.getCardAuth()
    }
    
    //Move to detail screen
    func moveToDetailScreen(detailModel:IndividualTransaction){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "TransactionDetailViewController") as! TransactionDetailViewController
       transactionDetailController.detailModel = detailModel
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//        let analysisController = storyBoard.instantiateViewController(withIdentifier: "AnalysisViewController") as! AnalysisViewController
//        self.navigationController?.pushViewController(analysisController, animated: false)
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
        cell.bindData(data: rowData,delegate: self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
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
        self.moveToDetailScreen(detailModel: self.transactionDataSource[indexPath.section].rowData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Here we check for last section and last row
        if indexPath.section == self.transactionDataSource.count-1 && indexPath.row == self.transactionDataSource[indexPath.section].rowData.count-1 {
            //we are at last section and last row. Right time to load more data
            if self.transactionListPresenter.hasMoreTransactionToLoad{
                self.transactionListPresenter.currentPage = self.transactionListPresenter.currentPage + 1
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: ledgersTableView.bounds.width, height: CGFloat(44))
                
                self.ledgersTableView.tableFooterView = spinner
                self.ledgersTableView.tableFooterView?.isHidden = false
                transactionListPresenter.sendTransactionListRequest()
            }else{
                self.ledgersTableView.tableFooterView?.isHidden = true
            }
        }
    }
}

extension HomeViewController:HomeDelegate{
    //MARK: HomeDelegate
    func didFetchedTransactionList(data: [TransactionListModel]) {
        
        if self.transactionDataSource.count > 0 {
            if data.count > 0 {

                var lastTransactionOfCurrentArr: TransactionListModel = self.transactionDataSource.last!
                let firstTransactionOfRecievedArr: TransactionListModel = data.first!
                // now compare date
                if Validations.matchTwoStrings(string1: lastTransactionOfCurrentArr.sectionTitle , string2: firstTransactionOfRecievedArr.sectionTitle ){
                    //they are same , means got transaction of same date in pagination
                    lastTransactionOfCurrentArr.rowData.append(contentsOf: firstTransactionOfRecievedArr.rowData)
                    self.transactionDataSource[self.transactionDataSource.count-1] = lastTransactionOfCurrentArr


                }else{
                    // it's of different date simply append result
                    self.transactionDataSource.append(contentsOf: data)
                }
            }
        }else{
            if data.count == 0 {
                self.vwEmpty.isHidden = false
            } else {
                self.vwEmpty.isHidden = true
            }
            self.transactionDataSource.append(contentsOf: data)
        }
        self.ledgersTableView.isHidden = !self.vwEmpty.isHidden
        self.ledgersTableView.reloadData()
        self.checkForFirstTimeLandOnHome()
    }
    func didFetchedError(error:ErrorModel){
        if error.getErrorMessage().contains("phone") {
            self.navigateToOTP()
        }
    }
    func didFetchedAccountInfo(data:Account){
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        if let _ = currentUser?.name{
            //self.GreetingLbl.text = AppUtility().greetingAccToTime() +(currentUser?.name)!
            let nameParts = currentUser?.name.split(separator: " ")
            self.GreetingLbl.text = AppUtility.greetingAccToTime()+(nameParts?.count == 0 ? "" : nameParts![0])
        }
        if !data.data.isPhoneVerified {
            self.navigateToOTP()
        }else if !data.data.isAccountVerified{
            self.moveToWaitList()
        }else{
            self.menuContainerViewController.panMode = MFSideMenuPanModeDefault
            self.showTabBar()
        }
        self.AccBalanceLbl.text = "$"+String(data.data.info.balance.amount)
        
        currentUser?.amount = data.data.info.balance.amount
        currentUser?.cardActivated = data.data.CardFirstTimeActivated
        
        if let premium = data.data.premiumStatus{
            let sideMenu = self.menuContainerViewController.leftMenuViewController as! SideMenuViewController
            sideMenu.premiumStatus = premium
        }
 
        UserInformationUtility.sharedInstance.saveUser(model: currentUser!)
        self.getTransactionList()
    }
}

extension HomeViewController:OTPControllerDelegates{
    func OTP_Verified(){
        self.getAccountInfo()
    }
}

extension HomeViewController{
    func hideTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame!.origin.y = self.view.frame.size.height + (frame?.size.height)!
        self.tabBarController?.tabBar.frame = frame!
    }
    
    func showTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame!.origin.y = self.view.frame.size.height - (frame?.size.height)!
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }

    func navigateToOTP(){
        return
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.delegate = self
        vc.screenWhichInitiatedOTP = AppConstants.Screens.HOME
        self.present(vc, animated: true) {
        }
    }
    
    func moveToWaitList(){
        return
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WaitListViewController") as! WaitListViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension HomeViewController:HomeTableCellDelegate{
    //Delete once client confirm
    func disputeTransactionClicked(data: IndividualTransaction) {
    }
}
extension HomeViewController:ShareAccountDetailDelegates{
    func didSharedAccounTDetails() {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.ACCOUNT_DETAIL_SAHRED_SUCCESSFULLY.rawValue)
    }
    
}

extension HomeViewController:CardAuthDelegates{
    func didFetchCardAuth(data: CardAuthData) {
        let sideMenu = self.menuContainerViewController.leftMenuViewController as! SideMenuViewController
        sideMenu.cardAuthData = self.cardAuthData
    }
}

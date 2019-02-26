//
//  TransactionDetailViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import GoogleMaps

class TransactionDetailViewController: BaseViewController {
    @IBOutlet weak var historyTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: GradientView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var beneficiaryNameLbl: UILabel!
    @IBOutlet weak var transactionPurposeLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var amtLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var transactionImg: UIImageView!
    //var detailModel:Transaction!
    var detailModel:Dummy!

    var historyOptions : [String] = [] {
        didSet {
            self.historyTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTitle()
        self.updateUIForRecievedData()
        self.configureTable()
        self.historyOptions.append(contentsOf: ["Number of Visits","Average Spend"])
    }
    
    override func loadView() {
        super.loadView()
        self.loadGoogleMap()
        
    }
    //Create gradient for navigation bar
    func setNavigationBarTitle(){
        // Set navigation Bar to normal translucent
        self.navigationController?.navigationBar.setTitleFont(UIFont(name: "Calibri-Bold", size: 15)!,color: Colors.Taupe776857)
        self.navigationController?.navigationBar.topItem?.title = "Transaction"
        self.navigationController?.navigationBar.makeNormal()
        var colors = [UIColor]()
        colors.append(UIColor(red: 252/255, green: 252/255, blue: 250/255, alpha: 0.3))
        colors.append(UIColor(red: 248/255, green: 247/255, blue: 244/255, alpha: 1))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        self.setupRightNavigationBar()
    }
    //Methode initialises the rightbutton for navigation
    override func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.popController)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    //Update Values on UI
    func updateUIForRecievedData(){
        
        //set shadow to container view
        var shadowOffst = CGSize.init(width: 0, height: -55)
        var shadowOpacity = 0.1
        var shadowRadius = 49
        var shadowColor = Colors.Zorba161149133
        self.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        shadowOffst = CGSize.init(width: 0, height: 6)
        shadowOpacity = 0.9
        shadowRadius = 16
        shadowColor = UIColor.init(red: 0, green: 107, blue: 79)
        self.transactionImg.layer.addShadowAndRoundedCorners(roundedCorner: 31, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
       // self.beneficiaryNameLbl.text = self.detailModel.transactionPrintout.beneficiaryname
        self.beneficiaryNameLbl.text = self.detailModel.name
        self.amtLbl.text =  String(self.detailModel.amount)
        self.transactionImg.image = self.detailModel.image
    }
    //Method to go back to previous screen
    @objc func popController(){
        self.navigationController?.popViewController(animated: false)
    }
    
    func loadGoogleMap(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 2.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView = mapView
    }
}
//MARK:- UITableView Delegate and DataSource
extension TransactionDetailViewController: UITableViewDelegate,UITableViewDataSource{
    //Setting up table view
    func configureTable(){
        self.historyTableView.rowHeight = 44;
        self.historyTableView.delegate=self
        self.historyTableView.dataSource=self
        self.historyTableView.registerTableViewCell(tableViewCell: TransactionDetailHistoryCell.self)
        self.historyTableView.registerTableViewHeaderFooterView(tableViewHeaderFooter: TransactionDetailHistoryTableHeader.self)
        self.historyTableViewHeightConstraint.constant=137
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TransactionDetailHistoryCell = tableView.dequeueReusableCell(withIdentifier: "TransactionDetailHistoryCell") as! TransactionDetailHistoryCell
        cell.bindData(value: self.historyOptions[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TransactionDetailHistoryTableHeader") as! TransactionDetailHistoryTableHeader
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 49
    }
}

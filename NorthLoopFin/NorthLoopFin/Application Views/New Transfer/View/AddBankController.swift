//
//  AddBankController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 10/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AddBankController: BaseViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var btnVerifyContinue: RippleButton!
    @IBOutlet weak var lblEmail: LabelWithLetterSpace!
    @IBOutlet weak var lblPhone: LabelWithLetterSpace!
    @IBOutlet weak var imgBankLogo: UIImageView!
    @IBOutlet weak var vwVerifyAccount: UIView!
    var optionArray:[String] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        configureTableView()
        configureCollectionView()
        optionArray = ["1","2","3","4"]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnVerifyContinue_pressed(_ sender: UIButton) {
        closeVerification()
    }
    
    @IBAction func btnBackVerify_pressed(_ sender: UIButton) {
        closeVerification()
    }
    
    @IBAction func btnCloseVerify_pressed(_ sender: UIButton) {
        closeVerification()
    }
    
    func openVerification(){
        self.vwVerifyAccount.isHidden = false
    }
    
    func closeVerification(){
        self.vwVerifyAccount.isHidden = true
    }

}

extension AddBankController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    /// Will configure collection View
    func configureCollectionView(){
        self.collectionView.dataSource=self
        self.collectionView.delegate=self
        collectionView.register(UINib.init(nibName: "BankCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BankCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankCollectionCell", for: indexPath) as! BankCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 3;
        let height = collectionView.frame.height/2
        return CGSize(width:widthPerItem, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        openVerification()
    }
}

extension AddBankController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 76;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerTableViewCell(tableViewCell: BankCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell") as! BankCell
        //        cell.bindData(option: optionArray[indexPath.row])
        cell.imgCheckbox.isHidden = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.LightGray251
        cell.selectedBackgroundView = bgColorView
        
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openVerification()
    }
}

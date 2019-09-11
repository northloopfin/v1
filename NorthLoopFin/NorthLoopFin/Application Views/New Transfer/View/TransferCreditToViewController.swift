//
//  TransferCreditToViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferCreditToViewController: BaseViewController {

    @IBOutlet weak var firstBankView: UIView!
    @IBOutlet weak var addBankAccountView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var optionArray:[String] = []{
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        configureTableView()
        optionArray = ["1","2"]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TransferCreditToViewController:UITableViewDelegate,UITableViewDataSource {
    
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
        cell.imgCheckbox.isHidden = indexPath.row == 0
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colors.LightGray251
        cell.selectedBackgroundView = bgColorView
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = vwAddAccountFooter.instantiateFromNib()
        footer.btnAddBank.addTarget(self, action: #selector(addBank), for: .touchUpInside)
        footer.lblAddBank.text = "Add the receiver bank account "
        footer.amountTextField.isHidden = optionArray.count == 0
        return footer
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return optionArray.count == 0 ? 56 : 156
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func addBank(){
        optionArray = ["1","2"]
//        self.navigationController?.pushViewController(self.getControllerWithIdentifier(""), animated: true)
    }
}

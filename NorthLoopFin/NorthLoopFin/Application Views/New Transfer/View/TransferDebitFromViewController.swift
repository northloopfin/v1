//
//  TransferDebitFromViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferDebitFromViewController: BaseViewController {

    @IBOutlet weak var firstBankView: UIView!
    @IBOutlet weak var secondBankView: UIView!
    @IBOutlet weak var addBankAccountView: UIView!
    @IBOutlet weak var addAmountTextField: UITextField!
    @IBOutlet weak var firstBankHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondBankHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var optionArray:[String] = []{
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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

extension TransferDebitFromViewController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        self.tableView.rowHeight = 91;
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerTableViewCell(tableViewCell: DebitFromCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebitFromCell") as! DebitFromCell
//        cell.bindData(option: optionArray[indexPath.row])
        cell.vwNorthLoop.isHidden = indexPath.row == 0
        cell.imgCheckbox.image = UIImage(named: indexPath.row == 0 ? "checkedBox" : "uncheckedBox")
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        cell.selectedBackgroundView = bgColorView
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = vwAddAccountFooter.instantiateFromNib()
        footer.btnAddBank.addTarget(self, action: #selector(addBank), for: .touchUpInside)
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func addBank(){
        optionArray = ["1","2"]
        self.navigationController?.pushViewController(self.getControllerWithIdentifier("AddBankController"), animated: true)
    }
}

public extension UIView {
    
    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
    
}

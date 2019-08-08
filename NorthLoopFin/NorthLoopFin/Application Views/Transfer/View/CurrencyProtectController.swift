//
//  CurrencyProtectController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 08/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CurrencyProtectController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var transactionDataSource: [String] = ["1","2","3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.configureTable()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
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

extension CurrencyProtectController:UITableViewDelegate,UITableViewDataSource{
    //Configure table view delgates and data source
    func configureTable(){
        self.tableView.rowHeight = 61;
        self.tableView.delegate=self
        self.tableView.dataSource=self
        self.tableView.registerTableViewCell(tableViewCell: CurrencyProtectCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencyProtectCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyProtectCell") as! CurrencyProtectCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 61.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

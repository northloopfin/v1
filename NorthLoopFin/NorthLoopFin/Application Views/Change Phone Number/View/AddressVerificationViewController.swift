//
//  AddressVerificationViewController.swift
//  Test
//
//  Created by Admin on 8/3/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

class AddressVerificationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public weak var delegate : AddressVerificationViewDelegate?
    public var dataSource:[[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onNext(_ sender: Any) {
        delegate?.uprovedVerifiedAddress()
        self.dismiss(animated: true)
    }
    
}

extension AddressVerificationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressVerificationTableViewCell", for: indexPath) as! AddressVerificationTableViewCell
        if indexPath.section == 0 {
            cell.option = AddreddCompareModel.init(addres1: dataSource[0][indexPath.row], address2: "")
        } else  {
            cell.option = AddreddCompareModel.init(addres1: dataSource[1][indexPath.row], address2: dataSource[0][indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let separator = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let img = UIImageView.init(frame:CGRect(x: tableView.frame.size.width / 2 - 8, y: 15, width: 18, height: 10))
        img.image = UIImage.init(named: "icon_arrow_bottom")
        separator.addSubview(img)
        return separator
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
    
}

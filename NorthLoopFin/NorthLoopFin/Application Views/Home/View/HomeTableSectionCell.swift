//
//  HomeTableSectionCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class HomeTableSectionCell: UITableViewHeaderFooterView {

    @IBOutlet weak var dateTxt: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func bindData(data:TransactionListModel){
        self.dateTxt.text = AppUtility.getDateFromUTCFormatUsingNumberOrdinal(dateStr: data.sectionTitle)
        
    }
}

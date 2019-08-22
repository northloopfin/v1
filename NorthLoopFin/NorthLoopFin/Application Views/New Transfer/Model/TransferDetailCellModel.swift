//
//  TransferDetailCellModel.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 20/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransferDetailCellModel {
    let mainTitleText: String
    let detailTitleText: String
    
    init(_ mainTitle:String, detailValue:String){
        self.mainTitleText = mainTitle
        self.detailTitleText = detailValue
    }
}

//
//  TransactionListModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionListModel {
    var sectionTitle: String
    var rowData:[IndividualTransaction]
    //var rowData:[Dummy]
    
    init(sectionTitle:String,rowData:[IndividualTransaction]) {
        self.sectionTitle=sectionTitle
        self.rowData=rowData
    }
//    init(sectionTitle:String,rowData:[Dummy]) {
//        self.sectionTitle=sectionTitle
//        self.rowData=rowData
//    }

}

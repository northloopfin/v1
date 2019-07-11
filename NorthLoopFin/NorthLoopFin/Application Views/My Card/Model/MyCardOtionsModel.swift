//
//  MyCardOtionsModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct MyCardOtionsModel {
    let option: String
    //let transactionInfo: TransactionInfo
    let haveSwitch: Bool
    var isSwitchSelected: Bool
    
    init(_ option:String, isSwitch:Bool, isSelected:Bool){
        self.option = option
        self.haveSwitch = isSwitch
        self.isSwitchSelected=isSelected
    }
}

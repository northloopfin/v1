//
//  AddreddCompareModel.swift
//  Test
//
//  Created by Admin on 8/3/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

class AddreddCompareModel {
    let title: String
    let isEqual: Bool

    init(addres1:String, address2:String) {
        self.title = addres1
        self.isEqual = address2.lowercased() == "" || addres1.lowercased() == address2.lowercased()
    }
}

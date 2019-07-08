//
//  Country.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 25/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
struct Country : Decodable {
    var name: String
    var code: String
    var dialCode: String
    
    init(name:String,code:String, dialCode:String) {
        self.name=name
        self.code=code
        self.dialCode=dialCode
    }
}

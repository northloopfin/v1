//
//  SignupFlowAddress.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupFlowAddress: Codable {
    let street, houseNo, city, state: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case street
        case houseNo = "house_no"
        case city, state, zip
    }
    
    init(street: String, houseNo: String, city: String, state: String, zip: String) {
        self.street = street
        self.houseNo = houseNo
        self.city = city
        self.state = state
        self.zip = zip
    }
}

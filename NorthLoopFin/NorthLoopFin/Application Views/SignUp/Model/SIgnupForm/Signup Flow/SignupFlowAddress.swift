//
//  SignupFlowAddress.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupFlowAddress: Codable {
    let street, city, state, house: String
    var zip,country: String
    
    enum CodingKeys: String, CodingKey {
        case street
        case city, state, zip, country
        case house = "house_no"
    }
    
    init(street: String, city: String, state: String, zip: String,countty:String,houseNumber:String) {
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.country = countty
        self.house = houseNumber
    }
}

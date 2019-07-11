//
//  UpdateAddressRequestBody.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 11/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

// MARK: - UpdateAddressRequestBody
class UpdateAddressRequestBody: Codable {
    let address: UpdatedAddress
    
    init(address: UpdatedAddress) {
        self.address = address
    }
}

// MARK: - Address
class UpdatedAddress: Codable {
    let houseNo, state, street, city: String
    let zip, country: String
    
    enum CodingKeys: String, CodingKey {
        case houseNo = "house_no"
        case state, street, city, zip, country
    }
    
    init(houseNo: String, state: String, street: String, city: String, zip: String, country: String) {
        self.houseNo = houseNo
        self.state = state
        self.street = street
        self.city = city
        self.zip = zip
        self.country = country
    }
}

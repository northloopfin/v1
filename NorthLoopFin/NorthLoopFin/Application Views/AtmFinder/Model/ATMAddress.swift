//
//  ATMAddress.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ATMAddress: Codable {
    let city: String
    let country: String
    let postalCode: String
    let state: String
    let street: String
    
    enum CodingKeys: String, CodingKey {
        case city
        case country
        case postalCode
        case state
        case street

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
        state = try values.decodeIfPresent(String.self, forKey: .state) ?? ""
        street = try values.decodeIfPresent(String.self, forKey: .street) ?? ""
        
    }
    
}

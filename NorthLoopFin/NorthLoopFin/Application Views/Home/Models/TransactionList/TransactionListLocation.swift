//
//  TransactionListLoction.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionListLocation: Codable {
    let addressCity, addressCountryCode, addressPostalCode, addressSubdivision: String
    let lat, lon: Double
    
    enum CodingKeys: String, CodingKey {
        case addressCity = "address_city"
        case addressCountryCode = "address_country_code"
        case addressPostalCode = "address_postal_code"
        case addressSubdivision = "address_subdivision"
        case lat, lon
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressCity = try values.decodeIfPresent(String.self, forKey: .addressCity) ?? ""
        addressCountryCode = try values.decodeIfPresent(String.self, forKey: .addressCountryCode) ?? ""
        addressPostalCode = try values.decodeIfPresent(String.self, forKey: .addressPostalCode) ?? ""
        addressSubdivision = try values.decodeIfPresent(String.self, forKey: .addressSubdivision) ?? ""
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
        lon = try values.decodeIfPresent(Double.self, forKey: .lon) ?? 0.0

    }
}

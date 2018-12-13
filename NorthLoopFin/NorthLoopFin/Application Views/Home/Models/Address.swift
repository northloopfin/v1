//
//  Address.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
class Address: Codable {
    
    let addressNumber, addressStreet, addressCity, addressPostalCode: String
    let addressISOCountry: String
    let addressRefinement: String?
    
    enum CodingKeys: String, CodingKey {
        case addressNumber = "address_number"
        case addressStreet = "address_street"
        case addressCity = "address_city"
        case addressPostalCode = "address_postal_code"
        case addressISOCountry = "address_iso_country"
        case addressRefinement = "address_refinement"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressNumber = try values.decodeIfPresent(String.self, forKey: .addressNumber) ?? ""
        addressStreet = try values.decodeIfPresent(String.self, forKey: .addressStreet) ?? ""
        addressCity = try values.decodeIfPresent(String.self, forKey: .addressCity) ?? ""
        addressPostalCode = try values.decodeIfPresent(String.self, forKey: .addressPostalCode) ?? ""
        addressISOCountry = try values.decodeIfPresent(String.self, forKey: .addressISOCountry) ?? ""
        addressRefinement = try values.decodeIfPresent(String.self, forKey: .addressRefinement) ?? ""
    }
}

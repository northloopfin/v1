//
//  ATMLocation.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ATMLocation: Codable {
    let address: ATMAddress
    let coordinates: ATMCoordinates
    let id: String
    let isAvailable24Hours, isDepositAvailable, isHandicappedAccessible, isOffPremise: Bool
    let isSeasonal: Bool
    let locationDescription, logoName, name: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case coordinates
        case id
        case isAvailable24Hours
        case isDepositAvailable
        case isHandicappedAccessible
        case isOffPremise
        case isSeasonal
        case locationDescription
        case logoName
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(ATMAddress.self, forKey: .address)!
        coordinates = try values.decodeIfPresent(ATMCoordinates.self, forKey: .coordinates)!
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        isAvailable24Hours = try values.decodeIfPresent(Bool.self, forKey: .isAvailable24Hours) ?? false
        isDepositAvailable = try values.decodeIfPresent(Bool.self, forKey: .isDepositAvailable) ?? false
        isHandicappedAccessible = try values.decodeIfPresent(Bool.self, forKey: .isHandicappedAccessible) ?? false
        isOffPremise = try values.decodeIfPresent(Bool.self, forKey: .isOffPremise) ?? false
        isSeasonal = try values.decodeIfPresent(Bool.self, forKey: .isSeasonal) ?? false
        locationDescription = try values.decodeIfPresent(String.self, forKey: .locationDescription) ?? ""
        logoName = try values.decodeIfPresent(String.self, forKey: .logoName) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

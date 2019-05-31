//
//  DometicTransferDetails.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
// MARK: - Domestic
struct DometicTransferDetails: Codable {
    let routing, bankName, bankAddress, accountNumber: String
    let accountType: String
    
    enum CodingKeys: String, CodingKey {
        case routing
        case bankName = "bank_name"
        case bankAddress = "bank_address"
        case accountNumber = "account_number"
        case accountType = "account_type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        routing = try values.decodeIfPresent(String.self, forKey: .routing) ?? ""
        bankName = try values.decodeIfPresent(String.self, forKey: .bankName) ?? ""
        bankAddress = try values.decodeIfPresent(String.self, forKey: .bankAddress) ?? ""
        accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber) ?? ""
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType) ?? ""
    }
}

//
//  Amount.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Amount: Codable {
    let amount: Double
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount) ?? 0.0
        currency = try values.decodeIfPresent(String.self, forKey: .currency) ?? ""
    }
}

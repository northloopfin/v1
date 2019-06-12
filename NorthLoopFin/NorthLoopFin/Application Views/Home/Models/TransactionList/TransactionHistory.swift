//
//  TransactionHistory.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


struct TransactionHistory: Codable {
    let data: TransactionHistoryData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(TransactionHistoryData.self, forKey: .data)!
    }
}

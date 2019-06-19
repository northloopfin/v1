//
//  ACHTransactionData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ACHTransactionData: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        
    }
}

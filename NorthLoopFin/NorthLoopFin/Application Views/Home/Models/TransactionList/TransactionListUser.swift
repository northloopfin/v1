//
//  TransactionListUser.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionListUser: Codable {
    let id: String
    let legalNames: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case legalNames = "legal_names"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        legalNames = try values.decodeIfPresent(Array<String>.self, forKey: .legalNames) ?? []
    }
}

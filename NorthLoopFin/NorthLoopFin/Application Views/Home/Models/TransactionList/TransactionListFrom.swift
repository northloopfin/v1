//
//  TransactionListFrom.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionListFrom: Codable {
    let id, nickname, type: String
    let user: TransactionListUser
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case type
        case user
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        user = try values.decodeIfPresent(TransactionListUser.self, forKey: .user)!
    }
}

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
    let meta: Recipient?
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case type
        case user
        case meta
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        user = try values.decodeIfPresent(TransactionListUser.self, forKey: .user)!
        meta = try values.decodeIfPresent(Recipient.self, forKey: .meta) ?? nil
//        if type == "EXTERNAL-US"{
//            meta = try values.decodeIfPresent(Recipient.self, forKey: .meta)!
//        }
    }
}

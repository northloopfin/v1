//
//  Recipient.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionDetailRecipient: Codable {
    let id: ID
    let meta: RecipientMeta
    let nickname: String
    let type: String
    //let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case meta
        //case attachments
        case nickname
        case type
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ID.self, forKey: .id)!
        meta = try values.decodeIfPresent(RecipientMeta.self, forKey: .meta)!
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
}


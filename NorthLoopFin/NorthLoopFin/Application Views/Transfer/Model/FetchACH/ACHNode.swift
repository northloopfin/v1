//
//  ACHNode.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ACHNode: Codable {
    let nickname, node_id, bank_name, account_num, bank_logo, allowed: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case node_id
        case bank_name
        case account_num
        case bank_logo
        case allowed
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        node_id = try values.decodeIfPresent(String.self, forKey: .node_id) ?? ""
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name) ?? ""
        account_num = try values.decodeIfPresent(String.self, forKey: .account_num) ?? ""
        bank_logo = try values.decodeIfPresent(String.self, forKey: .bank_logo) ?? ""
        allowed = try values.decodeIfPresent(String.self, forKey: .allowed) ?? ""
    }
}

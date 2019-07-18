//
//  ACHNode.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ACHNode: Codable {
    let nickname, nodeID, bank_name, account_num: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case nodeID = "node_id"
        case bank_name
        case account_num
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID) ?? ""
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name) ?? ""
        account_num = try values.decodeIfPresent(String.self, forKey: .account_num) ?? ""
    }
}

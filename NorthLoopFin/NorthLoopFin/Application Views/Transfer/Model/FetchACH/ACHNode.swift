//
//  ACHNode.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ACHNode: Codable {
    let nickname, nodeID: String
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case nodeID = "node_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID) ?? ""
    }
}

//
//  CardInfo.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CardAuth: Codable {
    let oAuth_key: String
    let user_id: String
    let node_id: String
    let subnet_id: String

    enum CodingKeys: String, CodingKey {
        case oAuth_key
        case user_id
        case node_id
        case subnet_id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        oAuth_key = try values.decodeIfPresent(String.self, forKey: .oAuth_key) ?? ""
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id) ?? ""
        node_id = try values.decodeIfPresent(String.self, forKey: .node_id) ?? ""
        subnet_id = try values.decodeIfPresent(String.self, forKey: .subnet_id) ?? ""
    }
}

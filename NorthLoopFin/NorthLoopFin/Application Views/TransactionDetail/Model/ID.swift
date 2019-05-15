//
//  ID.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ID: Codable {
    let oid: String?
    
    enum CodingKeys: String, CodingKey {
        case oid = "$oid"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        oid = try values.decodeIfPresent(String.self, forKey: .oid) ?? ""
    }
}

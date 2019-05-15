//
//  CreatedOn.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CreatedOn: Codable {
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "$date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(Int.self, forKey: .date) ?? 0
    }
}

//
//  UpgradeResponse.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct UpgradeResponse:Codable {
    let data: String
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        
    }
}

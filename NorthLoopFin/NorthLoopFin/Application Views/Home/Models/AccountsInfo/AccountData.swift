//
//  AccountData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
struct AccountData: Codable {
    let info: AccountInfo
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case info
        case isActive = "is_active"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(AccountInfo.self, forKey: .info)!
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive) ?? false
    }
}

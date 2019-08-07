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
    let isVerified: Bool
    let isPhoneVerified: Bool
    let isAccountVerified: Bool
    let CardFirstTimeActivated: Bool
    enum CodingKeys: String, CodingKey {
        case info
        case isActive = "is_active"
        case isVerified
        case isPhoneVerified
        case isAccountVerified
        case CardFirstTimeActivated
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(AccountInfo.self, forKey: .info)!
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive) ?? false
        isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        isAccountVerified = try values.decodeIfPresent(Bool.self, forKey: .isAccountVerified) ?? false
        isPhoneVerified = try values.decodeIfPresent(Bool.self, forKey: .isPhoneVerified) ?? false
        CardFirstTimeActivated = try values.decodeIfPresent(Bool.self, forKey: .CardFirstTimeActivated) ?? false
    }
}

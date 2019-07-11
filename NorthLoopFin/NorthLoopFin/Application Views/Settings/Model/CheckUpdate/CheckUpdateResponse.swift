//
//  CheckUpdateResponse.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 02/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CheckUpdateResponse: Codable {
    let appVersion: String
    let forceUpdate: Bool
    
    enum CodingKeys: String, CodingKey {
        case appVersion = "app_version"
        case forceUpdate = "force_update"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appVersion = try values.decodeIfPresent(String.self, forKey: .appVersion) ?? ""
        forceUpdate = try values.decodeIfPresent(Bool.self, forKey: .forceUpdate) ?? false
    }
}

//
//  BasicInfo.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct BasicInformation: Codable {
    let username, email,name: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case email = "email"
        case name = "name"

    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

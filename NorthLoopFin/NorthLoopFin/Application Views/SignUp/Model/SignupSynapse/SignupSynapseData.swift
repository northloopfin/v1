//
//  SignupSynapseData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct SignupSynapseData: Codable {
    let code: Int
    let message, oauthKey, userID: String
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case oauthKey = "oauth_key"
        case userID = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code) ?? 0
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        oauthKey = try values.decodeIfPresent(String.self, forKey: .oauthKey) ?? ""
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? ""

    }
}

//
//  SignUpAuth.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct SignupAuth: Codable {
    let message: String
    let data: SignupAuthData
    
    enum CodingKeys: String, CodingKey {
        
        case message, data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(SignupAuthData.self, forKey: .data)!
    }
}

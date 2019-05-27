//
//  ResetPassword.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ResetPassword: Codable {
    let message, data: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        
    }
}

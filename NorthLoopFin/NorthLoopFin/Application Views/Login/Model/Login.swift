//
//  Login.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
struct Login: Codable {
    
    let message: String
    let data: LoginData
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)!
        
    }
}

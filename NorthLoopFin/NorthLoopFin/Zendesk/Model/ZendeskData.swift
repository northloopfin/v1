//
//  ZendeskData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


struct ZendeskData: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        
    }
}

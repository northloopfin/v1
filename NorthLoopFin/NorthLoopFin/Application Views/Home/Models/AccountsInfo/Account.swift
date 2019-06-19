//
//  Account.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
struct Account: Codable {
    
    let data: AccountData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AccountData.self, forKey: .data)!
        
    }
    
}

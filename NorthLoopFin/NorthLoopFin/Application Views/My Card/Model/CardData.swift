//
//  CardData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CardData: Codable {
    let preferences: CardPreferences
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case preferences
        case status
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        preferences = try values.decodeIfPresent(CardPreferences.self, forKey: .preferences)!
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        
    }
}

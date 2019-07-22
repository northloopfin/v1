//
//  CardAuthData.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 22/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

struct CardAuthData: Codable {
    let data: CardAuth
    
    enum CodingKeys: String, CodingKey {
        case data
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CardAuth.self, forKey: .data)!
    }
}


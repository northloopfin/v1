//
//  ATM.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ATM: Codable {
    let atmLocation: ATMLocation
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
        case atmLocation
        case distance
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        atmLocation = try values.decodeIfPresent(ATMLocation.self, forKey: .atmLocation)!
        distance = try values.decodeIfPresent(Double.self, forKey: .distance) ?? 0.0
    }
}

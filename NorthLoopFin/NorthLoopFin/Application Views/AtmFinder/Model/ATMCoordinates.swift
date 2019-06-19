//
//  ATMCoordinates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

// MARK: - Coordinates
struct ATMCoordinates: Codable {
    let latitude, longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        latitude = try values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0.0
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0.0
        
    }
}

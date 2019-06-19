//
//  FetchACH.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct FetchACH: Codable {
    let data: [ACHNode]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent(Array<ACHNode>.self, forKey: .data)!
    }
}

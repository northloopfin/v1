//
//  FetchUniversityResponse.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 19/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct FetchUniversityResponse:Codable {
    let universitiesList: [String]
    
    enum CodingKeys: String, CodingKey {
        case universitiesList
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        universitiesList = try values.decodeIfPresent(Array<String>.self, forKey: .universitiesList) ?? []
        
    }
}

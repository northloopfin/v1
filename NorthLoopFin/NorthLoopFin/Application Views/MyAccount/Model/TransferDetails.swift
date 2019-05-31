//
//  TransferDetails.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransferDetails: Codable {
    let domestic: DometicTransferDetails
    let international: InternationalTransferDetails
    
    enum CodingKeys: String, CodingKey {
        case domestic
        case international
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        domestic = try values.decodeIfPresent(DometicTransferDetails.self, forKey: .domestic)!
        international = try values.decodeIfPresent(InternationalTransferDetails.self, forKey: .international)!
    }
}

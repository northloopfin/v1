//
//  DeleteACH.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

struct DeletedACHNode: Codable {
    let nodeID: String
    
    enum CodingKeys: String, CodingKey {
        case nodeID = "_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nodeID = try values.decodeIfPresent(String.self, forKey: .nodeID) ?? ""
    }
}

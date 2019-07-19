//
//  DeleteACH.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

struct DeleteACH: Codable {
    let data: DeletedACHNode
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent(DeletedACHNode.self, forKey: .data)!
    }
}

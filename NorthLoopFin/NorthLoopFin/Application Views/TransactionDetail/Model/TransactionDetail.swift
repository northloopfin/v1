//
//  TransactionDetail.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionDetail : Codable{
    let message: String
    let data: TransactionDetailData
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        data = try values.decodeIfPresent(TransactionDetailData.self, forKey: .data)!
        
    }
}

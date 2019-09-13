//
//  CurrencyProtect.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 28/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol FetchWireListDelegates:BaseViewProtocol {
    func didFetcWireList(data:[WireTransaction])
}

struct WireList: Codable {
    let data: [WireTransaction]
    
    enum CodingKeys: String, CodingKey {
        case data 
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Array<WireTransaction>.self, forKey: .data) ?? []
    }
}

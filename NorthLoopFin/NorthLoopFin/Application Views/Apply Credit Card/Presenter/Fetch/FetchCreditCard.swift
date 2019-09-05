//
//  FetchCreditCard.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol FetchCreditCardDelegate:BaseViewProtocol {
    func didFetchCreditCard(data:FetchCreditCard)
    func didFaildCreditCard()
}

struct FetchCreditCardData: Codable {
    let requested: Bool
}

struct FetchCreditCard: Codable {
    let data: FetchCreditCardData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FetchCreditCardData.self, forKey: .data)!
        
    }
}


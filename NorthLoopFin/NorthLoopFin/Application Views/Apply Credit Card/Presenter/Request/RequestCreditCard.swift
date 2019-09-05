//
//  RequestCreditCard.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol RequestCreditCardDelegate:BaseViewProtocol {
    func didRequestCreditCard()
    func didFaildCreditCard()
}

struct RequestCreditCardData: Codable {
    let message: String

    enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}


struct RequestCreditCard: Codable {
    let data: RequestCreditCardData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RequestCreditCardData.self, forKey: .data)!
        
    }
}


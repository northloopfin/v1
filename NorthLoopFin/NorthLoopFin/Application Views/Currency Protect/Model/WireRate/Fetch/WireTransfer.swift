//
//  WireTranfer.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 28/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


protocol FetchWireTransferDelegates:BaseViewProtocol {
    func didFetcWireTransfer(data:WireTransfer)
}

struct WireTransfer: Codable {
    let data: WireTransferData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(WireTransferData.self, forKey: .data)!
    }
}

struct WireTransferData: Codable {
    let transaction: WireTransaction
    let cashbackAmount: String
    let pastRates: [ExchangeRate]

    enum CodingKeys: String, CodingKey {
        case transaction = "transaction"
        case cashbackAmount = "cashback_amount"
        case pastRates = "past_exchange_rates"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transaction = try values.decodeIfPresent(WireTransaction.self, forKey: .transaction)!
        cashbackAmount = try values.decodeIfPresent(String.self, forKey: .cashbackAmount) ?? ""
        pastRates = try values.decodeIfPresent(Array<ExchangeRate>.self, forKey: .pastRates)!
    }
}

struct WireTransaction: Codable {
    let transaction_id: String
    let amount: String
    let exchange_rate: String
    let fav_exchange_rate: String
    let date: String
    let claimed: Bool
    let wire_from: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id) ?? ""
        amount = try values.decodeIfPresent(String.self, forKey: .amount) ?? ""
        exchange_rate = try values.decodeIfPresent(String.self, forKey: .exchange_rate) ?? ""
        fav_exchange_rate = try values.decodeIfPresent(String.self, forKey: .fav_exchange_rate) ?? ""
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
        wire_from = try values.decodeIfPresent(String.self, forKey: .wire_from) ?? ""
        claimed = try values.decodeIfPresent(Bool.self, forKey: .claimed) ?? false
    }
}

struct ExchangeRate: Codable {
    let date: String
    let inr: String
}


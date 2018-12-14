//
//  Transaction.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
struct Transaction: Codable {
    let paymentType, transactionType, transactionStatus: String
    //let transactionInfo: TransactionInfo
    let reference: String
    let amount: Int
    let failureReasons: [String]
    var ledgerFromID, transactionID, createdAt, partnerProduct: String
    let beneficiaryID: String
    let transactionPrintout: TransactionPrintout
    let assetType, assetClass: String
    let beneficiaryAccountID: String
    let transactionDate:String
    
    enum CodingKeys: String, CodingKey {
        case paymentType = "payment_type"
        case transactionType = "transaction_type"
        case transactionStatus = "transaction_status"
        //case transactionInfo = "transaction_info"
        case reference, amount
        case failureReasons = "failure_reasons"
        case ledgerFromID = "ledger_from_id"
        case transactionID = "transaction_id"
        case createdAt = "created_at"
        case partnerProduct = "partner_product"
        case beneficiaryID = "beneficiary_id"
        case transactionPrintout = "transaction_printout"
        case assetType = "asset_type"
        case assetClass = "asset_class"
       // case invoices
        case beneficiaryAccountID = "beneficiary_account_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType) ?? ""
        transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType) ?? ""
        transactionStatus = try values.decodeIfPresent(String.self, forKey: .transactionStatus) ?? ""
        reference = try values.decodeIfPresent(String.self, forKey: .reference) ?? ""
        amount = try values.decodeIfPresent(Int.self, forKey: .amount) ?? 0
        failureReasons = try values.decodeIfPresent([String].self, forKey: .failureReasons)!
        ledgerFromID = try values.decodeIfPresent(String.self, forKey: .ledgerFromID) ?? ""
        transactionID = try values.decodeIfPresent(String.self, forKey: .transactionID) ?? ""
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        partnerProduct = try values.decodeIfPresent(String.self, forKey: .partnerProduct) ?? ""
        beneficiaryID = try values.decodeIfPresent(String.self, forKey: .beneficiaryID) ?? ""
        partnerProduct = try values.decodeIfPresent(String.self, forKey: .partnerProduct) ?? ""
        transactionPrintout = try values.decodeIfPresent(TransactionPrintout.self, forKey: .transactionPrintout)!
        assetType = try values.decodeIfPresent(String.self, forKey: .assetType) ?? ""
        assetClass = try values.decodeIfPresent(String.self, forKey: .assetClass) ?? ""
        beneficiaryAccountID = try values.decodeIfPresent(String.self, forKey: .beneficiaryAccountID) ?? ""
        transactionDate = AppUtility.getDateFromUTCFormat(dateStr: createdAt)
    }
}

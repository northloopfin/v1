//
//  Other.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Other: Codable {
    let approved, asyncRan: Bool
    //let attachments: [JSONAny]
    let createEmailSent: Bool
    //let disputeForm: JSONNull?
    let disputed, doNext: Bool
   // let process: Process
    //let provisionalCreditTransactionID, settlementBatchID: JSONNull?
    let showQueue, skipValidation: Bool
    
    enum CodingKeys: String, CodingKey {
        case approved
        case asyncRan = "async_ran"
        //case attachments
        case createEmailSent = "create_email_sent"
       // case disputeForm = "dispute_form"
        case disputed
        case doNext = "do_next"
        //case process
        //case provisionalCreditTransactionID = "provisional_credit_transaction_id"
        //case settlementBatchID = "settlement_batch_id"
        case showQueue = "show_queue"
        case skipValidation = "skip_validation"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        approved = try values.decodeIfPresent(Bool.self, forKey: .approved) ?? false
        asyncRan = try values.decodeIfPresent(Bool.self, forKey: .asyncRan) ?? false
        createEmailSent = try values.decodeIfPresent(Bool.self, forKey: .createEmailSent) ?? false
        disputed = try values.decodeIfPresent(Bool.self, forKey: .disputed) ?? false
        doNext = try values.decodeIfPresent(Bool.self, forKey: .doNext) ?? false
        showQueue = try values.decodeIfPresent(Bool.self, forKey: .showQueue) ?? false
        skipValidation = try values.decodeIfPresent(Bool.self, forKey: .skipValidation) ?? false

    }
}

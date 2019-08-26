//
//  AccountInfo.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct AccountInfo: Codable {
    let balance: AccountBalance
    let documentID: String
    //let monthlyWithdrawalsRemaining: JSONNull?
    let nameOnAccount, nickname: String
    
    enum CodingKeys: String, CodingKey {
        case balance
        case documentID = "document_id"
        case nameOnAccount = "name_on_account"
        case nickname
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = try values.decodeIfPresent(AccountBalance.self, forKey: .balance)!
        documentID = try values.decodeIfPresent(String.self, forKey: .documentID) ?? ""
        nameOnAccount = try values.decodeIfPresent(String.self, forKey: .nameOnAccount) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""

    }
}


struct PremiumStatus: Codable {
    let current_plan, validity: String
    let auto_renew: Bool
    
    enum CodingKeys: String, CodingKey {
        case current_plan
        case validity
        case auto_renew
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        current_plan = try values.decodeIfPresent(String.self, forKey: .current_plan) ?? ""
        validity = try values.decodeIfPresent(String.self, forKey: .validity) ?? ""
        auto_renew = try values.decodeIfPresent(Bool.self, forKey: .auto_renew) ?? false        
    }
}

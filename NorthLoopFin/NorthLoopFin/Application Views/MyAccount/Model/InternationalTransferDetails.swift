//
//  InternationalTransferDetails.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

// MARK: - International
struct InternationalTransferDetails: Codable {
    let swift, intermediaryBank, intermediaryBankAddress, beneficiaryName: String
    let beneficiaryAccountNumber, beneficiaryAddress: String
    
    enum CodingKeys: String, CodingKey {
        case swift
        case intermediaryBank = "intermediary_bank"
        case intermediaryBankAddress = "intermediary_bank_address"
        case beneficiaryName = "beneficiary_name"
        case beneficiaryAccountNumber = "beneficiary_account_number"
        case beneficiaryAddress = "beneficiary_address"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        swift = try values.decodeIfPresent(String.self, forKey: .swift) ?? ""
        intermediaryBank = try values.decodeIfPresent(String.self, forKey: .intermediaryBank) ?? ""
        intermediaryBankAddress = try values.decodeIfPresent(String.self, forKey: .intermediaryBankAddress) ?? ""
        beneficiaryName = try values.decodeIfPresent(String.self, forKey: .beneficiaryName) ?? ""
        beneficiaryAccountNumber = try values.decodeIfPresent(String.self, forKey: .beneficiaryAccountNumber) ?? ""
        beneficiaryAddress = try values.decodeIfPresent(String.self, forKey: .beneficiaryAddress) ?? ""
    }
}

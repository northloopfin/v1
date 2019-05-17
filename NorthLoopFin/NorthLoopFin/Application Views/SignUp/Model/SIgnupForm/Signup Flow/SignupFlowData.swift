//
//  SignupFlowData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupFlowData: Codable {
    var userID, userIP, email: String
    var phoneNumbers, legalNames: [String]
    var password: String
    var documents: SignupFlowDocument
    var suppID: String
    var cipTag: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userIP = "user_ip"
        case email
        case phoneNumbers = "phone_numbers"
        case legalNames = "legal_names"
        case password, documents
        case suppID = "supp_id"
        case cipTag = "cip_tag"
    }
    
    init(userID: String, userIP: String, email: String, phoneNumbers: [String], legalNames: [String], password: String, documents: SignupFlowDocument, suppID: String, cipTag: Int) {
        self.userID = userID
        self.userIP = userIP
        self.email = email
        self.phoneNumbers = phoneNumbers
        self.legalNames = legalNames
        self.password = password
        self.documents = documents
        self.suppID = suppID
        self.cipTag = cipTag
    }
}

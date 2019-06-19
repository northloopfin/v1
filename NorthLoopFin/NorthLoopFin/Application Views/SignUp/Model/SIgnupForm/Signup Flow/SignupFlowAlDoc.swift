//
//  SignupFlowAlDoc.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class SignupFlowAlDoc: Codable {
    var documentValue, documentType: String
    
    enum CodingKeys: String, CodingKey {
        case documentValue = "document_value"
        case documentType = "document_type"
    }
    
    init(documentValue: String, documentType: String) {
        self.documentValue = documentValue
        self.documentType = documentType
    }
}

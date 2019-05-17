//
//  SignupFlowDocument.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupFlowDocument: Codable {
    var entityScope, email, phoneNumber, ip: String
    var name, entityType: String
    var day, month, year: Int
    var desiredScope, docsKey: String
    var virtualDocs, physicalDocs: [SignupFlowAlDoc]
    
    enum CodingKeys: String, CodingKey {
        case entityScope = "entity_scope"
        case email
        case phoneNumber = "phone_number"
        case ip, name
        case entityType = "entity_type"
        case day, month, year
        case desiredScope = "desired_scope"
        case docsKey = "docs_key"
        case virtualDocs = "virtual_docs"
        case physicalDocs = "physical_docs"
    }
    
    init(entityScope: String, email: String, phoneNumber: String, ip: String, name: String, entityType: String, day: Int, month: Int, year: Int, desiredScope: String, docsKey: String, virtualDocs: [SignupFlowAlDoc], physicalDocs: [SignupFlowAlDoc]) {
        self.entityScope = entityScope
        self.email = email
        self.phoneNumber = phoneNumber
        self.ip = ip
        self.name = name
        self.entityType = entityType
        self.day = day
        self.month = month
        self.year = year
        self.desiredScope = desiredScope
        self.docsKey = docsKey
        self.virtualDocs = virtualDocs
        self.physicalDocs = physicalDocs
    }
}

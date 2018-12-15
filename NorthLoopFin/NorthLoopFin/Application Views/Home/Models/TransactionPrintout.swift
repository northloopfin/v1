//
//  TransactionPrintout.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
struct TransactionPrintout:Codable {
    let ultimatesenderaddress: Address
    let beneficiaryiban, intermediarypsp, pspofsendername, pspaccounttandcscountryofjurisdiction: String
    let ultimatesendername, paymentonbehalfoftype, pspofultimatebenename, ultimatesenderaccountnumber: String
    let beneficiaryname, intermediarypspphysicallocation, paymentpartytype: String
    let intermediarypspaddress: Address
    
}

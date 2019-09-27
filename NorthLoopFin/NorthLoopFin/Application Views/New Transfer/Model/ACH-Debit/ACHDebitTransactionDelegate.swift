//
//  ACHDebitTransaction.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol ACHDebitTransactionDelegate:BaseViewProtocol {
    func didFetchACHDebitTransaction(data:TransactionDetail)
}

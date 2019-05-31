//
//  MyAccountDelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol UserTransferDetailDelegate:BaseViewProtocol {
    func didFetchUserTransactionDetail(data: UserTransferDetailData)
}

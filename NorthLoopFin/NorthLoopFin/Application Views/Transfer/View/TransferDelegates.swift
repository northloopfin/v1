//
//  TransferDelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol LinkACHDelegates:BaseViewProtocol {
    func didSentLinkACH()
}
protocol FetchACHDelegates:BaseViewProtocol {
    func didSentFetchACH(data:[ACHNode])
}
protocol ACHTransactionDelegates:BaseViewProtocol {
    func didSentFetchACH()
}

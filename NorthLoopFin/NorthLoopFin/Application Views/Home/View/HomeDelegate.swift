//
//  HomeDelegate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
protocol HomeDelegate:BaseViewProtocol {
    func didFetchedTransactionList(data: [Transaction])
}

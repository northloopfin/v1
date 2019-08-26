//
//  UpgradeDelegates.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol UpgradeDelegates: BaseViewProtocol {
    func didUpgradePremium()
    func didFailedUpgradePremium()
}

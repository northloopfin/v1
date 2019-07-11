//
//  ChangePhoneDelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol ChangePhoneDelegate: BaseViewProtocol {
    func didPhoneChanged()
}
protocol ChangeAddressDelegate: BaseViewProtocol {
    func didAddressChanged()
}


//
//  TwoFADelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


protocol TwoFADelegates: BaseViewProtocol {
    func didGetOTP()
}

protocol TwoFAVerifyDelegates: BaseViewProtocol {
    func didVerifiedOTP()
}

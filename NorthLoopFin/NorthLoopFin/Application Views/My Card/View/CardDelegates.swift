//
//  CardDelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol CardDelegates: BaseViewProtocol {
    func didFetchCardStatus(data:Card)
}

protocol CardInfoDelegates: BaseViewProtocol {
    func didFetchCardInfo(data:CardInfo)
}

protocol CardAuthDelegates: BaseViewProtocol {
    func didFetchCardAuth(data:CardAuthData)
}

protocol UpdateCardDelegates :BaseViewProtocol{
    func didUpdateCardStatus(data:Card)
}
protocol SetPinDelegates :BaseViewProtocol{
    func didSetPinSuccessful()
}


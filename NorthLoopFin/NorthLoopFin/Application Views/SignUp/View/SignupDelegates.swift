//
//  PhoneVerificationDelegate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

protocol PhoneVerificationDelegate: BaseViewProtocol{
     func didSentOTP(result:PhoneVerifyStart)
     func didCheckOTP(result:PhoneVerifyCheck)
}



protocol ImagePreviewDelegate {
    func imageUpdatedFor(index: Int, image:UIImage)
}

protocol SignupAuthDelegate:BaseViewProtocol {
    func didSignrdUPAuth(data:SignupAuth)
    
}

protocol SignupSynapseDelegate:BaseViewProtocol {
    func didSignedUpSynapse(data:SignupSynapse)    
}
protocol FetchUniversityDelegates:BaseViewProtocol{
    func didFetchedUniversityList()
}


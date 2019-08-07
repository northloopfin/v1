//
//  2FAVerifyPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class TwoFAVerifyPresenter:ResponseCallback{
    
    private weak var delegate          : TwoFAVerifyDelegates?
    private lazy var logic         : TwoFAVerifyBusinessModel = TwoFAVerifyBusinessModel()
    
    init(delegate responseDelegate:TwoFAVerifyDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func verifyTwoFARequest(sendToAPI:Bool, otp:String){
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = TwoFAVerifyRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
//            .addRequestQueryParams(key: "mfa", value: otp as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()+"false?"
        if sendToAPI{
            requestModel.apiUrl = requestModel.getEndPointMobile()+"?mfa="+otp
        }
        self.logic.verifyTwoFA(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didVerifiedOTP()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

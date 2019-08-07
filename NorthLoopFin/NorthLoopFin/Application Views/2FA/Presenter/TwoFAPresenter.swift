//
//  2FAPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class TwoFAPresenter:ResponseCallback{
    
    private weak var delegate          : TwoFADelegates?
    private lazy var logic         : TwoFABusinessLogic = TwoFABusinessLogic()
    
    init(delegate responseDelegate:TwoFADelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendTwoFARequest(sendToAPI:Bool){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = TwoFARequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .build()
            if sendToAPI{
                requestModel.apiUrl = requestModel.getEndPointForMobile()
            }else{
                requestModel.apiUrl = requestModel.getEndPoint()+"false"
            }
        
        self.logic.performTwoFA(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
       // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didGetOTP()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

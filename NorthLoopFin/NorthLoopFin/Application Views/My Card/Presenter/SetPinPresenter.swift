//
//  SetPinPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SetPinPresenter:ResponseCallback{
    
    private weak var delegate          : SetPinDelegates?
    private lazy var logic         : SetPinBusinessLogic = SetPinBusinessLogic()
    
    init(delegate responseDelegate:SetPinDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func setPinRequest(pin:String){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = SetPinRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "card_pin", value: pin as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performSetPin(withRequestModel: requestModel, presenterDelegate: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didSetPinSuccessful()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

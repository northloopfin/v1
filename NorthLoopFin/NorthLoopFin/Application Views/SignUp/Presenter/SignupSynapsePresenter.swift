//
//  SignupSynapsePresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupSynapsePresenter:ResponseCallback{
    
    private weak var delegate          : SignupSynapseDelegate?
    private lazy var logic         : SignupSynapseBusinessLogic = SignupSynapseBusinessLogic()
    
    init(delegate responseDelegate:SignupSynapseDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func startSignUpSynapse(requestDic:[String:AnyObject]){
        self.delegate?.showLoader()
        var token:String=""
        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken){
            token = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken) as! String
        }else{
            if let currentUser = UserInformationUtility.sharedInstance.getCurrentUser(){
                token = currentUser.accessToken
            }
        }
        
        let requestModel = SignupSynapseRequestModel.Builder().addRequestHeader(key: Endpoints.APIRequestHeaders.CONTENT_TYPE.rawValue, value: Endpoints.APIRequestHeaders.APPLICATION_JSON.rawValue)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: token )
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .build()
        requestModel.requestQueryParams = requestDic
        requestModel.apiUrl = requestModel.getEndPoint() + (requestDic.keys.contains("ssn") ? "/3" : "")
        self.logic.performSignUpSynapse(withRequestModel: requestModel, presenterDelegate: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        print(responseObject)
        let response = responseObject as! SignupSynapse
        self.delegate?.hideLoader()
        //self.delegate?.didFetchCardStatus(data: response)
        self.delegate?.didSignedUpSynapse(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.delegate?.didFailedSynapse()
    }
}


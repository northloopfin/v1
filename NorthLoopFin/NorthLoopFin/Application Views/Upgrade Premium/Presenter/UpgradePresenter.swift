//
//  UpgradePresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpgradePresenter:ResponseCallback{
    
    private weak var delegate          : UpgradeDelegates?
    private lazy var logic         : UpgradeBusinessLogic = UpgradeBusinessLogic()
    
    init(delegate responseDelegate:UpgradeDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendUpgradePremiumRequest(sendToAPI:Bool){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = UpgradeRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: "127.0.0.1")
            .addRequestQueryParams(key: "isUpgrade", value: sendToAPI as AnyObject)
            .addRequestQueryParams(key: "ip", value: UIDeviceHelper.getIPAddress() as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performUpgaredPremium(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didUpgradePremium()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

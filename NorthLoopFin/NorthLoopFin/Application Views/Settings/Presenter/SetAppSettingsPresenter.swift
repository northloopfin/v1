//
//  SetAppSettingsPresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 28/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SetAppSettingsPresenter:ResponseCallback{
    
    private weak var delegate          : SettingsDelegates?
    private lazy var logic         : SetAppSettingsBusinessLogic = SetAppSettingsBusinessLogic()
    
    init(delegate responseDelegate:SettingsDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendSaveAppSettingsRequest(isTransactionOn:Bool,isLowBalanceOn:Bool, isDealOfferOn:Bool, isTipOn:Bool, tipPercentage:Int){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = SetAppSettingsRequestModel.Builder()
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "transaction", value: isTransactionOn as AnyObject)
            .addRequestQueryParams(key: "low_balance", value: isLowBalanceOn as AnyObject)
            .addRequestQueryParams(key: "deals_offers", value: isDealOfferOn as AnyObject)
            .addRequestQueryParams(key: "tip_suggestion", value: isTipOn as AnyObject)
            .addRequestQueryParams(key: "tip_percentage", value: tipPercentage as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performSaveAppSettings(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        //let response = responseObject as! FetchUniversityResponse
        self.delegate?.hideLoader()
        self.delegate?.didSaveAppSettings()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

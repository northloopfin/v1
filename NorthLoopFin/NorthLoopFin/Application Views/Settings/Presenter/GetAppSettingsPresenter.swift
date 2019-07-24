//
//  AppSettingsPresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 20/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class GetAppSettingsPresenter:ResponseCallback{
    
    private weak var delegate          : SettingsDelegates?
    private lazy var logic         : GetAppSettingsBusinessLogic = GetAppSettingsBusinessLogic()
    
    init(delegate responseDelegate:SettingsDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendGetAppSettingsRequest(){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = GetAppSettingsRequestModel.Builder()
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performGetAppSettings(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! GetAppSettingsResponse
        self.delegate?.hideLoader()
        self.delegate?.didGetAppSettings(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

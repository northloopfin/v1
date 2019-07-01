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
    
    func sendSaveAppSettingsRequest(){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = SetAppSettingsRequestModel.Builder()
            .addRequestHeader(key: "ip", value: "127.0.0.1")
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
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

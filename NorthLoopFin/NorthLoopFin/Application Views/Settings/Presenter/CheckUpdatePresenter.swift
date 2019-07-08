//
//  CheckUpdatePresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 02/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class CheckUpdatePresenter:ResponseCallback{
    
    private weak var delegate          : SettingsDelegates?
    private lazy var logic         : CheckUpdateBusinessLogic = CheckUpdateBusinessLogic()
    
    init(delegate responseDelegate:SettingsDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendCheckUpdateCall(){
        
        self.delegate?.showLoader()
        //let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = CheckUpdateRequestModel.Builder()
            .addRequestHeader(key: "ip", value: "127.0.0.1")
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performCheckUpdate(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! CheckUpdateResponse
        self.delegate?.hideLoader()
        self.delegate?.didCheckUpdate(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

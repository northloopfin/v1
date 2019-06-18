//
//  ZendeskPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ZendeskPresenter: ResponseCallback{
    
    private weak var delegate          : ZendeskDelegates?
    private lazy var businessLogic         : ZendeskBusiness = ZendeskBusiness()
    
    //    Constructor
    init(delegate responseDelegate:ZendeskDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendZendeskTokenRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ZendeskRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: "127.0.0.1")//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .build()
        print(requestModel.requestHeader)
        print(requestModel.requestQueryParams)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performZendeskToken(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! ZendeskResponse
        self.delegate?.didSentZendeskToken(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

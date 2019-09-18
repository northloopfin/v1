//
//  AccountAggregatePresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class AccountAggregatePresenter: ResponseCallback{
    
    private weak var delegate          : AccountAggregateDelegate?
    private lazy var businessLogic         : AccountAggregateBusinessLogic = AccountAggregateBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:AccountAggregateDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendAccountAggregateRequest(bank:String,id:String,password:String){
        self.delegate?.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!

        let requestModel = AccountAggregateRequestModel.Builder()
            .addRequestQueryParams(key: "bank_name", value: bank as AnyObject)
            .addRequestQueryParams(key: "bank_pw", value: password as AnyObject)
            .addRequestQueryParams(key: "bank_id", value: id as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .build()
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performAccountAggregate(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func sendMFARequest(token:String,answer:String){
        self.delegate?.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        
        let requestModel = AccountAggregateRequestModel.Builder()
            .addRequestQueryParams(key: "mfa_answer", value: answer as AnyObject)
            .addRequestQueryParams(key: "access_token", value: token as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .build()
        requestModel.apiUrl=requestModel.getEndPoint() + "?mfa=true"
        self.businessLogic.performAccountAggregate(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? AccountAggregate{
            self.delegate?.didFetchAccountAggregate(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

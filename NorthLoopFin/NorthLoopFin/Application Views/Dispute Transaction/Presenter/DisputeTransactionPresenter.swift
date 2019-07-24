//
//  DisputeTransactionPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class DisputeTransactionPresenter: ResponseCallback{
    
    private weak var delegate          : DisputeTransactionDelegates?
    private lazy var businessLogic         : DisputeTransactionBusinessModel = DisputeTransactionBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:DisputeTransactionDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendDisputeIssue(transactionId:String,reason:String){
        self.delegate?.showLoader()
        
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        
        let requestModel = DisputeTransactionRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "tx_id", value: transactionId as AnyObject)
            .addRequestQueryParams(key: "dispute_reason", value: reason as AnyObject)
            .build()
        
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performDispute(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        //let response = responseObject as! ATMFinder
        self.delegate?.didSentDisputeTransactionRequest()
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

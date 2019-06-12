//
//  ACHTransactionPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ACHTransactionPresenter: ResponseCallback{
    
    private weak var delegate          : ACHTransactionDelegates?
    private lazy var businessLogic         : ACHTransactionBusinessModel = ACHTransactionBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:ACHTransactionDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendACHTransactionRequest(amount:String,nodeID:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ACHTransactionRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "value", value: amount as AnyObject)
            .addRequestQueryParams(key: "send_to_id", value: nodeID as AnyObject)
            .addRequestQueryParams(key: "ip", value: UIDeviceHelper.getIPAddress()! as AnyObject)
            .build()
        print(requestModel.requestHeader)
        print(requestModel.requestQueryParams)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performACHTransaction(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! ACHTransaction
        self.delegate?.didSentFetchACH()
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

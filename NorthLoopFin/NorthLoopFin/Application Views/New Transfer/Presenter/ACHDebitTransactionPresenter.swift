//
//  ACHDebitTransactionPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ACHDebitTransactionPresenter: ResponseCallback{
    
    private weak var delegate          : ACHDebitTransactionDelegate?
    private lazy var businessLogic         : ACHDebitTransactionBusinessModel = ACHDebitTransactionBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:ACHDebitTransactionDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendACHDebitTransactionRequest(amount:String,nodeID:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ACHDebitTransactionRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "value", value: amount as AnyObject)
            .addRequestQueryParams(key: "currency", value: "USD" as AnyObject)
            .addRequestQueryParams(key: "from_id", value: nodeID as AnyObject)
            .addRequestQueryParams(key: "ip", value: UIDevice.current.ipAddress() as AnyObject)//UIDeviceHelper.getIPAddress()! as AnyObject)
            .build()
        print(requestModel.requestHeader)
        print(requestModel.requestQueryParams)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performACHDebitTransaction(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? TransactionDetail{
            self.delegate?.didFetchACHDebitTransaction(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

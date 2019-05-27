//
//  TransactionDetailPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import FGRoute


class TransactionDetailPresenter: ResponseCallback{
    private weak var delegate          : TransactionDetailDelegate?
    private lazy var businessLogic         : TransactionDetialBusinessLogic = TransactionDetialBusinessLogic()
    //MARK:- Constructor
    
    init(delegate responseDelegate:TransactionDetailDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendTransactionDetailRequest(transactionId:Int){
        self.delegate?.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let rquestModel = TransactionDetailRequestModel.Builder().addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken).addRequestQueryParams(key:"id", value : transactionId as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        rquestModel.apiUrl = rquestModel.getEndPoint()+"/"+String(transactionId)
        self.businessLogic.performTransactionDetail( withRequestModel: rquestModel, presenterDelegate:self)

    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        let response = responseObject as! TransactionDetail
        self.delegate?.didFetchedTransactionDetail(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle()
            , alertMessage: error.getErrorMessage())
    }
}

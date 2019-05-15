//
//  TransactionDetailPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class TransactionDetailPresenter: ResponseCallback{
    private weak var delegate          : TransactionDetailDelegate?
    private lazy var businessLogic         : TransactionDetialBusinessLogic = TransactionDetialBusinessLogic()
    //MARK:- Constructor
    
    init(delegate responseDelegate:HomeDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendTransactionDetailRequest(transactionId:Int){
        self.delegate.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()
        let rquestModel = TransactionDetailRequestModel.Builder().addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken).addRequestQueryParams(key:"", value : transactionId)
        self.businessLogic.perfornTransactionDetail
//        self.homeDelegate?.showLoader()
//        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
//        let requestModel = TransactionDetailRequestModel.Builder()
//            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
//                , value: currentUser.accessToken).
//        .addquesy.build()
////        self.businessLogic.performTransactionList(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
//        self.businessLogic.sendTransactionDetailRequest(withRequestModel requestModel: requestModel, presenterDelegate:ResponseCallback)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        
    }
    
    func servicesManagerError(error: ErrorModel) {
        
    }
}

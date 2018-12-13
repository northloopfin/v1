//
//  HomePresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

class HomePresenter: ResponseCallback{
    private weak var homeDelegate          : HomeDelegate?
    private lazy var homeTransactionListBusinessLogic         : HomeTransactionListBusinessLogic = HomeTransactionListBusinessLogic()
    //MARK:- Constructor
    
    init(delegate responseDelegate:HomeDelegate){
        self.homeDelegate = responseDelegate
    }
    //MARK:- Methods to make decision and call CapsuleList Api.
    
    func sendTransactionListRequest(){
        self.homeDelegate?.showLoader()
        
        let requestModel = HomeLedgerRequestModel.Builder()
            .addRequestHeader(key:AppConstants.APIRequestHeaders.ACCEPT.rawValue, value: AppConstants.APIRequestHeaders.APPLICATION_JSON.rawValue)
            .addRequestHeader(key: AppConstants.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: AppConstants.AuthorisationRequestHeader).build()
        
        //self.capsuleListBusinessLogic.performCapsuleList(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
        self.homeTransactionListBusinessLogic.performTransactionList(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
    }
    
    //MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! [Transaction]
        self.homeDelegate?.didFetchedTransactionList(data: response)
        self.homeDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.homeDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.homeDelegate?.hideLoader()
    }
    
}

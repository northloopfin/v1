//
//  HomePresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

class TransactionListPresenter: ResponseCallback{
    private weak var homeDelegate          : HomeDelegate?
    private lazy var homeTransactionListBusinessLogic         : HomeTransactionListBusinessLogic = HomeTransactionListBusinessLogic()
    //MARK:- Constructor
    
    init(delegate responseDelegate:HomeDelegate){
        self.homeDelegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendTransactionListRequest(){
        self.homeDelegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = TransactionListRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken).build()
    self.homeTransactionListBusinessLogic.performTransactionList(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
    }
    
    //MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! [TransactionHistory]
        let requiredData = self.createRequiredData(data: response)
        self.homeDelegate?.didFetchedTransactionList(data: requiredData)
        self.homeDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.homeDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.homeDelegate?.hideLoader()
    }
    
    //MARK: Create data to show on UI
    func createRequiredData(data:[TransactionHistory]) -> [TransactionListModel] {
        var dataArr:[TransactionListModel] = []
        let dic:Dictionary = Dictionary(grouping: data, by: {$0.createdAt})
        let dicKeys = Array(dic.keys)
        for key in dicKeys {
            let transactionArr:[TransactionHistory] = dic[key]!
            let section = transactionArr[0].createdAt
            let transationListModel:TransactionListModel = TransactionListModel.init(sectionTitle: section, rowData: transactionArr)
            dataArr.append(transationListModel)
        }
        return dataArr
    }
}

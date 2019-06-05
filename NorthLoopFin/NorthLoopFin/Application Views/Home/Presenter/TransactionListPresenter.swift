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
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.USERID.rawValue, value: currentUser.userID)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .addRequestQueryParams(key: "page", value: 1 as AnyObject)
            .addRequestQueryParams(key: "per_page", value: 10 as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
    self.homeTransactionListBusinessLogic.performTransactionList(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
    }
    
    //MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! TransactionHistory
        let requiredData = self.createRequiredData(data: response.data.trans)
        self.homeDelegate?.didFetchedTransactionList(data: requiredData)
        self.homeDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.homeDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.homeDelegate?.hideLoader()
    }
    
    //MARK: Create data to show on UI
    func createRequiredData(data:[IndividualTransaction]) -> [TransactionListModel] {
        var dataArr:[TransactionListModel] = []
        let dic  = Dictionary.init(grouping: data) { (element) -> Date in
            element.date
        }
        // sort keys here
        let sortedKeys = dic.keys.sorted()
        sortedKeys.forEach { (key) in
            //print(key)
            let values = dic[key]
            //print(values)
            let date = AppUtility.dateFromMilliseconds(seconds: Double(values![0].extra.createdOn))
            let transationListModel:TransactionListModel = TransactionListModel.init(sectionTitle: date, rowData: values ?? [])
            dataArr.append(transationListModel)
        }
        return dataArr
    }
}

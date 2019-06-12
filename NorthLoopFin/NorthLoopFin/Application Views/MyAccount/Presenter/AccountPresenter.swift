//
//  AccountPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class AccountPresenter: ResponseCallback{
    
    private weak var delegate          : UserTransferDetailDelegate?
    private lazy var businessLogic         : AccountBusinessModel = AccountBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:UserTransferDetailDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendFetchTransferDetailRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = AccountAPIRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        print(requestModel.requestQueryParams)
        requestModel.apiUrl=requestModel.getEndPoint()
    self.businessLogic.performFetchUserTransferDetail(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! UserTransferDetail
        self.delegate?.didFetchUserTransactionDetail(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

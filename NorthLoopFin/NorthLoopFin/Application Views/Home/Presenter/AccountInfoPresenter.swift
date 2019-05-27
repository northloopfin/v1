//
//  AccountInfoPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import FGRoute


class AccountInfoPresenter: ResponseCallback{
    private weak var homeDelegate          : HomeDelegate?
    private lazy var businessLogic         : AccountInfoBusinessLogic = AccountInfoBusinessLogic()
    //MARK:- Constructor
    
    init(delegate responseDelegate:HomeDelegate){
        self.homeDelegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func getAccountInfo(){
        self.homeDelegate?.showLoader()
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = AccountInfoRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()

        self.businessLogic.performAccountInfo(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! Account
        self.homeDelegate?.didFetchedAccountInfo(data: response)
        self.homeDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.homeDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.homeDelegate?.hideLoader()
    }
}

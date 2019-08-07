//
//  ChangeAddressPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class ChangeAddressPresenter:ResponseCallback{
    
    private weak var delegate          : ChangeAddressDelegate?
    private lazy var logic         : ChangeAddressBusinessModel = ChangeAddressBusinessModel()
    
    init(delegate responseDelegate:ChangeAddressDelegate){
        self.delegate = responseDelegate
    }
    
    //MARK:- Methods to make decision and call  Api.
    
    func sendChangeAddressRequest(requestDic:[String:AnyObject]) {
        // convert requestbody to json string and assign to request model request param
        self.delegate?.showLoader()
    
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ChangeAddressRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .build()
        requestModel.requestQueryParams = requestDic
        requestModel.apiUrl = requestModel.getEndPoint()
        self.logic.performChangeAddress(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func sendVerificateAddressRequset(requestDic:[String:AnyObject]) {
        self.delegate?.showLoader()

        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ChangeAddressRequestModel.Builder().build()
        requestModel.requestQueryParams = requestDic
        requestModel.apiUrl = Endpoints.APIEndpoints.SIGNUPSYNAPSE.rawValue
        self.logic.performChangeAddress(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didAddressChanged()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

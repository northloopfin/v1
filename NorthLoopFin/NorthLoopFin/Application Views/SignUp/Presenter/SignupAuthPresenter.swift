//
//  SignupAuthPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupAuthPresenter:ResponseCallback{
    
    private weak var delegate          : SignupAuthDelegate?
    private lazy var logic         : SignupAuthBusinessModel = SignupAuthBusinessModel()
    
    init(delegate responseDelegate:SignupAuthDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func startSignUpAuth(email:String, password:String){
        self.delegate?.showLoader()

        let requestModel = SignupAuthRquestModel.Builder()
            //.addRequestHeader(key: Endpoints.APIRequestHeaders.CONTENT_TYPE.rawValue, value: Endpoints.APIRequestHeaders.URLENCODED.rawValue)
            .addRequestQueryParams(key: "username", value: email as AnyObject)
            .addRequestQueryParams(key: "family_name", value: "test" as AnyObject)
            .addRequestQueryParams(key: "given_name", value: "test" as AnyObject)
            .addRequestQueryParams(key: "password", value: password as AnyObject).build()
        requestModel.apiUrl = requestModel.getEndPoint()
        self.logic.performSignUpAuth(withRequestModel: requestModel, presenterDelegate: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        print(responseObject)
        let response = responseObject as! SignupAuth
        self.delegate?.hideLoader()
        //self.delegate?.didFetchCardStatus(data: response)
        self.delegate?.didSignrdUPAuth(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}


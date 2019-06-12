//
//  ResetPasswordPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ResetPasswordPresenter: ResponseCallback{
    
    private weak var delegate          : ResetPasswordDelegate?
    private lazy var businessLogic         : ResetPasswordBusinessLogic = ResetPasswordBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:ResetPasswordDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendResetPasswordRequesy(username name:String){
        self.delegate?.showLoader()
        
        let requestModel = ResetPasswordRequestModel.Builder()
            .addRequestQueryParams(key: "username", value: name as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performResetPassword(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! ResetPassword
        self.delegate?.didSentResetPasswordRequest()
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

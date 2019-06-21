//
//  PhoneVerificationCheckPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
class PhoneVerificationCheckPresenter: ResponseCallback{
    
    private weak var phoneVerificationDelegate          : PhoneVerificationDelegate?
    private lazy var phoneVerificationLogic         : PhoneVerificationBusinessLogic = PhoneVerificationBusinessLogic()
    //MARK:- Constructor
    
    init(delegate phoneVrifyDelegate:PhoneVerificationDelegate){
        self.phoneVerificationDelegate = phoneVrifyDelegate
    }
    
    func sendPhoneVerificationCheckRequest(code:String){
        var countryCode = ""
        var phone = ""
        if Env.isStaging(){
            countryCode = "91"
            phone = "9716787065"
        }else if Env.isProduction(){
            countryCode = "1"
            phone = "3476739875"
        }
        self.phoneVerificationDelegate?.showLoader()
        let requestModel = PhoneVerificationRequestModel.Builder()
            .addRequestHeader(key:Endpoints.APIRequestHeaders.CONTENT_TYPE.rawValue, value: AppConstants.TwilioAPIKey!)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.COUNTRY_CODE.rawValue, value: countryCode as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.PHONE_NUMBER.rawValue, value: phone as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.VERIFICATION_CODE.rawValue, value: code as AnyObject).build()
        self.phoneVerificationLogic.performPhoneVerificationCheck(withPhoneVerification: requestModel, presenterDelagte: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.phoneVerificationDelegate?.didCheckOTP(result: responseObject as! PhoneVerifyCheck)
        self.phoneVerificationDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.phoneVerificationDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.phoneVerificationDelegate?.hideLoader()
    }
}

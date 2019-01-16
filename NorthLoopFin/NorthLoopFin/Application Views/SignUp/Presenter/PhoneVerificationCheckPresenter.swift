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
        self.phoneVerificationDelegate?.showLoader()
        let requestModel = PhoneVerificationRequestModel.Builder()
            .addRequestHeader(key:AppConstants.APIRequestHeaders.TWILIO_AUTHORIZATION_KEY.rawValue, value: AppConstants.TwilioAPIKey!)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.COUNTRY_CODE.rawValue, value: "91" as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.PHONE_NUMBER.rawValue, value: "9716787065" as AnyObject)
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

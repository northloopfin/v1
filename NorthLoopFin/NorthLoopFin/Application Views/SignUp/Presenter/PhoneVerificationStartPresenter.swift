//
//  PhoneVerificationPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
class PhoneVerificationStartPresenter: ResponseCallback{
    
    private weak var phoneVerificationDelegate          : PhoneVerificationDelegate?
    private lazy var phoneVerificationLogic         : PhoneVerificationBusinessLogic = PhoneVerificationBusinessLogic()
    //MARK:- Constructor
    
    init(delegate phoneVrifyDelegate:PhoneVerificationDelegate){
        self.phoneVerificationDelegate = phoneVrifyDelegate
    }
    
    func sendPhoneVerificationRequest(){
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
            .addRequestHeader(key:AppConstants.APIRequestHeaders.TWILIO_AUTHORIZATION_KEY.rawValue, value: AppConstants.TwilioAPIKey!)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.VIA.rawValue
                , value: "sms" as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.COUNTRY_CODE.rawValue, value: countryCode as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.PHONE_NUMBER.rawValue, value: phone as AnyObject)
            .addRequestQueryParams(key: AppConstants.TwilioPhoneVerificationRequestParamKeys.LOCALE.rawValue, value: "en" as AnyObject).build()
        self.phoneVerificationLogic.performPhoneVerification(withCapsuleListRequestModel: requestModel, presenterDelegate: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.phoneVerificationDelegate?.didSentOTP(result: responseObject as! PhoneVerifyStart)
        self.phoneVerificationDelegate?.hideLoader()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.phoneVerificationDelegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
        self.phoneVerificationDelegate?.hideLoader()
    }
}

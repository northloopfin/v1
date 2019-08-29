//
//  ReferralPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ReferralPresenter: ResponseCallback{
    
    private weak var delegate          : ReferralDelegate?
    private lazy var businessLogic         : ReferralBusinessLogic = ReferralBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:ReferralDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendReferralRequest(invitedBy:String){
        var token:String=""

        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken){
            token = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken) as! String
        }else{
            if let currentUser = UserInformationUtility.sharedInstance.getCurrentUser(){
                token = currentUser.accessToken
            }
        }
        
        let requestModel = ReferralRequestModel.Builder().addRequestHeader(key: Endpoints.APIRequestHeaders.CONTENT_TYPE.rawValue, value: Endpoints.APIRequestHeaders.APPLICATION_JSON.rawValue)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: token )
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())
            .build()
        requestModel.requestQueryParams = ["referrer_auth0_id":invitedBy] as [String : AnyObject]
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performReferral(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? Referral{
            print(response)
            UserDefaults.removeUserDefaultForKey(AppConstants.ReferralId)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
    }
}

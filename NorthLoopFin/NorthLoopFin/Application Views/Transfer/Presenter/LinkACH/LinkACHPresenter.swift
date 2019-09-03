//
//  LinkACHPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class LinkACHPresenter: ResponseCallback{
    
    private weak var delegate          : LinkACHDelegates?
    private lazy var businessLogic         : LinkACHBusinessLogic = LinkACHBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:LinkACHDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendLinkACRequest(nickname name:String, accountNo:String, rountingNo:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = LinkACHRquestModel.Builder()
            .addRequestQueryParams(key: "nickname", value: name as AnyObject).addRequestQueryParams(key: "account_num", value: accountNo as AnyObject).addRequestQueryParams(key: "routing_num", value: rountingNo as AnyObject)
            .addRequestQueryParams(key: "email_id", value: currentUser.userEmail as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.USERID.rawValue, value: currentUser.userID)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performLinkACH(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        self.delegate?.didSentLinkACH()
        //save this user to local memory of app
        //let response = responseObject as! ResetPassword
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

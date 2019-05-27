//
//  LoginPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class LoginPresenter: ResponseCallback{
    
    private weak var loginDelegate          : LoginDelegate?
    private lazy var loginBusinessLogic         : LoginBusinessLogic = LoginBusinessLogic()
    
//    Constructor
    init(delegate responseDelegate:LoginDelegate){
        self.loginDelegate = responseDelegate
    }
    
//    Send Login Request to Business Login
    func sendLoginRequest(username name:String, password:String){
          self.loginDelegate?.showLoader()
        
        let requestModel = LoginRequestModel.Builder()
            .addRequestQueryParams(key: "username", value: name as AnyObject)
            .addRequestQueryParams(key: "password", value: password as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDeviceHelper.getIPAddress()!)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        print(requestModel.apiUrl)
        self.loginBusinessLogic.performLogin(withLoginRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.loginDelegate?.hideLoader()
        //save this user to local memory of app
        let loginResponse = responseObject as! Login
        self.saveLoggedInUser(data: loginResponse.data)
        self.loginDelegate?.didLoggedIn(data: loginResponse.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        print(error.getErrorMessage())
        self.loginDelegate?.didLoginFailed(error: error)
        self.loginDelegate?.hideLoader()
    }
    
    
    /// Will Save logged in user to local storage of app
    func saveLoggedInUser(data:LoginData){
        let user:User = User.init(username: data.basicInformation.username, email: data.basicInformation.email, accesstoken: data.accessToken)
        user.authKey=data.oAuthKey
        UserInformationUtility.sharedInstance.saveUser(model: user)
    }
}

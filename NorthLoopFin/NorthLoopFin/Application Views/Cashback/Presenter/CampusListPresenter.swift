//
//  CampusPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CampusPresenter: ResponseCallback{
    
    private weak var delegate          : CampusDelegate?
    private lazy var businessLogic         : CampusBusinessLogic = CampusBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:CampusDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendCampusRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!

        let requestModel = CampusRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performCampus(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? CampusData{
            self.delegate?.didFetchCampus(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

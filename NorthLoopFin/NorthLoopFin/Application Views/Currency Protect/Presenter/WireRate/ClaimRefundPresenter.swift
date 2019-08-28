//
//  ClaimRefundPresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 28/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class ClaimRefundPresenter: ResponseCallback{
    
    private weak var delegate          : ClaimRefundDelegate?
    private lazy var businessLogic         : ClaimRefundBusinessLogic = ClaimRefundBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:ClaimRefundDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendClaimRequest(transactionID:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ClaimRefundRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl = requestModel.getEndPoint(transactionID: transactionID)
        self.businessLogic.performClaimRefund(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? ClaimRefund{
            self.delegate?.didClaimRefund(data:response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}

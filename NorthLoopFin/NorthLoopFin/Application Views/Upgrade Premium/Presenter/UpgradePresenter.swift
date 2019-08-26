//
//  UpgradePresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpgradePresenter:ResponseCallback{
    
    private weak var delegate          : UpgradeDelegates?
    private lazy var logic         : UpgradeBusinessLogic = UpgradeBusinessLogic()
    
    init(delegate responseDelegate:UpgradeDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendUpgradePremiumRequest(isMonthly:Bool){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = UpgradeRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestQueryParams(key: "upgradePlan", value: (isMonthly ? "monthly":"yearly") as AnyObject)
            .addRequestQueryParams(key: "ip", value: UIDeviceHelper.getIPAddress() as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performUpgaredPremium(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        if let response = responseObject as? UpgradeResponse{
            if response.data.count > 0{
                self.delegate?.showErrorAlert("", alertMessage: response.data)
            }
        }
        self.delegate?.didUpgradePremium()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.didFailedUpgradePremium()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}

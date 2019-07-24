//
//  UniversityPresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 19/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UniversityPresenter:ResponseCallback{
    
    private weak var delegate          : FetchUniversityDelegates?
    private lazy var logic         : FetchUniversityBusinessModel = FetchUniversityBusinessModel()
    
    init(delegate responseDelegate:FetchUniversityDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendFEtchUniversityListRequest(){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        //let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = FetchUniversityRequestModel.Builder()
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken) as! String)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performFetchUniversityList(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! FetchUniversityResponse
        self.delegate?.hideLoader()
        self.delegate?.didFetchedUniversityList(data: response.universitiesList)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
